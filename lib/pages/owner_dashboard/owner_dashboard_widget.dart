import 'package:flutter/material.dart';
import '../../services/statistics_service.dart';

class OwnerDashboardWidget extends StatefulWidget {
  const OwnerDashboardWidget({super.key});

  @override
  State<OwnerDashboardWidget> createState() => _OwnerDashboardWidgetState();
}

class _OwnerDashboardWidgetState extends State<OwnerDashboardWidget> {
  late StatisticsService _statsService;
  late Future<Map<String, dynamic>> _globalStats;
  late Future<Map<String, List<Map<String, dynamic>>>> _weeklyPlanning;
  late Future<Map<String, Map<String, List<Map<String, dynamic>>>>> _sallesDispo;
  
  DateTime _selectedDate = DateTime.now();
  DateTime _startOfWeek = DateTime.now();
  
  @override
  void initState() {
    super.initState();
    _statsService = StatisticsService();
    _loadData();
  }
  
  void _loadData() {
    setState(() {
      _globalStats = _statsService.getGlobalStatistics();
      _weeklyPlanning = _statsService.getWeeklyPlanning(startOfWeek: _startOfWeek);
      _sallesDispo = _statsService.getSallesDisponibilite(date: _selectedDate);
    });
  }
  
  void _previousWeek() {
    setState(() {
      _startOfWeek = _startOfWeek.subtract(const Duration(days: 7));
      _loadData();
    });
  }
  
  void _nextWeek() {
    setState(() {
      _startOfWeek = _startOfWeek.add(const Duration(days: 7));
      _loadData();
    });
  }
  
  void _goToToday() {
    setState(() {
      _startOfWeek = DateTime.now();
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
          title: const Text(
            'Dashboard Owner',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFFE50914),
            labelColor: Color(0xFFE50914),
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.bar_chart), text: 'Statistiques'),
              Tab(icon: Icon(Icons.calendar_month), text: 'Planning'),
              Tab(icon: Icon(Icons.location_city), text: 'Salles'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: _loadData,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildStatisticsTab(),
            _buildPlanningTab(),
            _buildSallesTab(),
          ],
        ),
      ),
    );
  }
  
  // ============================================================
  // TAB 1: STATISTIQUES
  // ============================================================
  
  Widget _buildStatisticsTab() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _globalStats,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFFE50914)));
        }
        
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Erreur chargement stats', style: TextStyle(color: Colors.white70)));
        }
        
        final stats = snapshot.data!;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carte Total Séances
              _buildStatCard(
                title: 'Total Séances',
                value: '${stats['totalSeances']}',
                icon: Icons.movie,
                color: const Color(0xFFE50914),
              ),
              const SizedBox(height: 16),
              
              // Format et Qualité
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Format VO',
                      value: '${(stats['formatCount'] as Map)['VO'] ?? 0}',
                      icon: Icons.ondemand_video,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Format VF',
                      value: '${(stats['formatCount'] as Map)['VF'] ?? 0}',
                      icon: Icons.ondemand_video,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: '2D',
                      value: '${(stats['qualityCount'] as Map)['2D'] ?? 0}',
                      icon: Icons.crop_original,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: '3D',
                      value: '${(stats['qualityCount'] as Map)['3D'] ?? 0}',
                      icon: Icons.crop_3_2,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Top 5 films
              const Text(
                'Top 5 films les plus projetés',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...(stats['top5Films'] as List).asMap().entries.map((entry) {
                final index = entry.key + 1;
                final film = entry.value;
                return _buildTopFilmCard(
                  rank: index,
                  name: film['name'],
                  count: film['count'],
                );
              }),
              const SizedBox(height: 16),
              
              // Répartition par jour
              const Text(
                'Répartition par jour',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildJourChart(stats['jourCount'] as Map<String, int>),
              const SizedBox(height: 16),
              
              // Répartition par heure
              const Text(
                'Répartition par horaire',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildHeureChart(stats['heureCount'] as Map<String, int>),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTopFilmCard({
    required int rank,
    required String name,
    required int count,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: rank == 1 ? const Color(0xFFE50914) : const Color(0xFF333333),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rank',
                style: TextStyle(
                  color: rank == 1 ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE50914).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count séances',
              style: const TextStyle(color: Color(0xFFE50914), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildJourChart(Map<String, int> jourCount) {
    final jours = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    final maxValue = jourCount.values.isEmpty 
        ? 1 
        : jourCount.values.reduce((a, b) => a > b ? a : b).toDouble();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: jours.map((jour) {
          final count = jourCount[jour] ?? 0;
          final height = maxValue > 0 ? (count / maxValue) * 100 : 0.0;
          
          return Column(
            children: [
              Text(
                count.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                width: 30,
                height: height,
                decoration: BoxDecoration(
                  color: const Color(0xFFE50914),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                jour.substring(0, 3),
                style: const TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildHeureChart(Map<String, int> heureCount) {
    final tranches = [
      'Matin (8h-12h)',
      'Midi (12h-14h)',
      'Après-midi (14h-18h)',
      'Soirée (18h-22h)',
      'Nuit (22h-2h)'
    ];
    
    final maxValue = heureCount.values.isEmpty 
        ? 1 
        : heureCount.values.reduce((a, b) => a > b ? a : b).toDouble();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: tranches.map((tranche) {
          final count = heureCount[tranche] ?? 0;
          final width = maxValue > 0 ? (count / maxValue) * 200 : 0.0;
          String shortLabel = '';
          if (tranche.contains('Matin')) shortLabel = '🌅 Matin';
          else if (tranche.contains('Midi')) shortLabel = '☀️ Midi';
          else if (tranche.contains('Après-midi')) shortLabel = '📅 Après-midi';
          else if (tranche.contains('Soirée')) shortLabel = '🌙 Soirée';
          else shortLabel = '🌃 Nuit';
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(shortLabel, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ),
                Expanded(
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF333333),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE50914),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Center(
                          child: Text(
                            count.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  
  // ============================================================
  // TAB 2: PLANNING HEBDOMADAIRE
  // ============================================================
  
  Widget _buildPlanningTab() {
    return Column(
      children: [
        // Navigation semaine
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border(bottom: BorderSide(color: const Color(0xFF333333))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: _previousWeek,
              ),
              TextButton(
                onPressed: _goToToday,
                child: Text(
                  'Semaine du ${_startOfWeek.day}/${_startOfWeek.month}',
                  style: const TextStyle(color: Color(0xFFE50914), fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: _nextWeek,
              ),
            ],
          ),
        ),
        
        // Planning
        Expanded(
          child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
            future: _weeklyPlanning,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Color(0xFFE50914)));
              }
              
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text('Erreur chargement planning', style: TextStyle(color: Colors.white70)));
              }
              
              final planning = snapshot.data!;
              
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  for (int i = 0; i < 7; i++)
                    _buildDayPlanningCard(
                      jour: _getJourSemaineInt(i + 1),
                      date: _startOfWeek.add(Duration(days: i)),
                      seances: planning[_getJourSemaineInt(i + 1)] ?? [],
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildDayPlanningCard({
    required String jour,
    required DateTime date,
    required List<Map<String, dynamic>> seances,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: seances.isNotEmpty ? const Color(0xFFE50914) : const Color(0xFF333333),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: seances.isNotEmpty ? 14 : 12,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              jour,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFE50914).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${seances.length} séance${seances.length > 1 ? 's' : ''}',
                style: const TextStyle(color: Color(0xFFE50914), fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        children: seances.isEmpty
            ? [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text('Aucune séance ce jour', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ),
                ),
              ]
            : seances.map((seance) => _buildSeancePlanningItem(seance)).toList(),
      ),
    );
  }
  
  Widget _buildSeancePlanningItem(Map<String, dynamic> seance) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            alignment: Alignment.center,
            child: Text(
              seance['heure'],
              style: const TextStyle(color: Color(0xFFE50914), fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seance['film'],
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: Color(0xFFAAAAAA)),
                    const SizedBox(width: 4),
                    Text(seance['salle'], style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 11)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE50914).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        seance['format'],
                        style: const TextStyle(color: Color(0xFFE50914), fontSize: 9, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        seance['quality'],
                        style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white70, size: 18),
            onPressed: () {
              Navigator.pushNamed(context, 'updateseance', arguments: {'seanceRef': seance['id']});
            },
          ),
        ],
      ),
    );
  }
  
  // ============================================================
  // TAB 3: DISPONIBILITÉ DES SALLES
  // ============================================================
  
  Widget _buildSallesTab() {
    return Column(
      children: [
        // Sélecteur de date
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border(bottom: BorderSide(color: const Color(0xFF333333))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Disponibilité des salles',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                        _sallesDispo = _statsService.getSallesDisponibilite(date: _selectedDate);
                      });
                    },
                  ),
                  Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.add(const Duration(days: 1));
                        _sallesDispo = _statsService.getSallesDisponibilite(date: _selectedDate);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Affichage des salles
        Expanded(
          child: FutureBuilder<Map<String, Map<String, List<Map<String, dynamic>>>>>(
            future: _sallesDispo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Color(0xFFE50914)));
              }
              
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text('Erreur chargement salles', style: TextStyle(color: Colors.white70)));
              }
              
              final salles = snapshot.data!;
              
              return ListView(
                padding: const EdgeInsets.all(16),
                children: salles.entries.map((entry) {
                  return _buildSalleCard(
                    salleName: entry.key,
                    horaires: entry.value,
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildSalleCard({
    required String salleName,
    required Map<String, List<Map<String, dynamic>>> horaires,
  }) {
    final creneaux = [
      '8:00 - 9:00', '9:00 - 10:00', '10:00 - 11:00', '11:00 - 12:00',
      '12:00 - 13:00', '13:00 - 14:00', '14:00 - 15:00', '15:00 - 16:00',
      '16:00 - 17:00', '17:00 - 18:00', '18:00 - 19:00', '19:00 - 20:00',
      '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00'
    ];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFE50914).withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.theaters, color: Color(0xFFE50914), size: 20),
        ),
        title: Text(
          salleName,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Capacité: ~150 places',
          style: TextStyle(color: Colors.white70, fontSize: 11),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: creneaux.map((creneau) {
                final seances = horaires[creneau] ?? [];
                bool isOccupied = seances.isNotEmpty;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: isOccupied ? const Color(0xFFE50914).withValues(alpha: 0.15) : const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          creneau,
                          style: TextStyle(
                            color: isOccupied ? const Color(0xFFE50914) : Colors.white70,
                            fontSize: 11,
                            fontWeight: isOccupied ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                      Expanded(
                        child: isOccupied
                            ? Wrap(
                                spacing: 8,
                                children: seances.map((seance) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE50914),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          seance['heure'],
                                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          seance['film'],
                                          style: const TextStyle(color: Colors.white, fontSize: 10),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            : const Text(
                                'Disponible',
                                style: TextStyle(color: Colors.green, fontSize: 11),
                              ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  String _getJourSemaineInt(int weekday) {
    const jours = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    return jours[weekday - 1];
  }
}