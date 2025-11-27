
// // import 'dart:async';
// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // // import 'package:vetto_ai/widgets/vetto_scaffold.dart'; // Removed to fix error

// // // --- 1. MODELS ---

// // enum WorkflowStatus { active, pending, completed, error, paused }
// // enum WorkflowPriority { low, medium, high, critical }

// // class WorkflowUser {
// //   final String id;
// //   final String name;
// //   final String avatarUrl;
  
// //   const WorkflowUser({required this.id, required this.name, required this.avatarUrl});
// // }

// // class WorkflowStep {
// //   final String id;
// //   final String title;
// //   final String description;
// //   final bool isCompleted;

// //   const WorkflowStep({
// //     required this.id, 
// //     required this.title, 
// //     required this.description, 
// //     this.isCompleted = false,
// //   });
// // }

// // class Workflow {
// //   final String id;
// //   final String title;
// //   final String description;
// //   final WorkflowStatus status;
// //   final WorkflowPriority priority;
// //   final double progress;
// //   final List<WorkflowStep> steps;
// //   final List<String> tags;
// //   final List<WorkflowUser> assignees;
// //   final DateTime createdAt;

// //   const Workflow({
// //     required this.id,
// //     required this.title,
// //     required this.description,
// //     required this.status,
// //     required this.priority,
// //     required this.progress,
// //     required this.steps,
// //     required this.tags,
// //     required this.assignees,
// //     required this.createdAt,
// //   });
// // }

// // // --- 2. MAIN PAGE ---

// // class WorkflowManagerPage extends StatefulWidget {
// //   const WorkflowManagerPage({super.key});

// //   @override
// //   State<WorkflowManagerPage> createState() => _WorkflowManagerPageState();
// // }

// // class _WorkflowManagerPageState extends State<WorkflowManagerPage> with TickerProviderStateMixin {
// //   // --- State ---
// //   bool _isLoading = true;
// //   String _searchQuery = "";
// //   String _currentFilter = "All";
// //   String _sortBy = "Newest"; 
  
// //   // Data
// //   final List<Workflow> _allWorkflows = [];
// //   List<Workflow> _displayWorkflows = [];
// //   final TextEditingController _searchController = TextEditingController();
// //   final ScrollController _scrollController = ScrollController();

// //   // Animations
// //   late AnimationController _fabController;
// //   late Animation<double> _fabScale;
// //   late AnimationController _bgController;
// //   late Animation<double> _doodleMoveAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
    
// //     // Background Animation
// //     _bgController = AnimationController(
// //       duration: const Duration(seconds: 6),
// //       vsync: this,
// //     )..repeat(reverse: true);
// //     _doodleMoveAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
// //       CurvedAnimation(parent: _bgController, curve: Curves.easeInOut),
// //     );

// //     // FAB Entrance
// //     _fabController = AnimationController(
// //       vsync: this, 
// //       duration: const Duration(milliseconds: 400)
// //     );
// //     _fabScale = CurvedAnimation(parent: _fabController, curve: Curves.easeOutBack);
// //     _fabController.forward();

// //     _loadData();
// //   }

// //   @override
// //   void dispose() {
// //     _bgController.dispose();
// //     _fabController.dispose();
// //     _searchController.dispose();
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   // --- DATA LOGIC ---

// //   Future<void> _loadData() async {
// //     await Future.delayed(const Duration(milliseconds: 800));
// //     if (!mounted) return;

// //     setState(() {
// //       _allWorkflows.clear();
// //       _allWorkflows.addAll(_generateComplexMockData());
// //       _applyFilters();
// //       _isLoading = false;
// //     });
// //   }

// //   void _applyFilters() {
// //     List<Workflow> temp = List.from(_allWorkflows);

// //     // 1. Search
// //     if (_searchQuery.isNotEmpty) {
// //       temp = temp.where((w) => 
// //         w.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
// //         w.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
// //         w.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()))
// //       ).toList();
// //     }

// //     // 2. Status Filter
// //     if (_currentFilter != "All") {
// //       temp = temp.where((w) => 
// //         w.status.name.toLowerCase() == _currentFilter.toLowerCase()
// //       ).toList();
// //     }

// //     // 3. Sorting
// //     switch (_sortBy) {
// //       case "Newest":
// //         temp.sort((a, b) => b.createdAt.compareTo(a.createdAt));
// //         break;
// //       case "Oldest":
// //         temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
// //         break;
// //       case "Progress":
// //         temp.sort((a, b) => b.progress.compareTo(a.progress));
// //         break;
// //       case "Priority":
// //         temp.sort((a, b) => b.priority.index.compareTo(a.priority.index));
// //         break;
// //     }

// //     setState(() {
// //       _displayWorkflows = temp;
// //     });
// //   }

// //   void _handleCreateWorkflow(Workflow newWorkflow) {
// //     setState(() {
// //       _allWorkflows.insert(0, newWorkflow);
// //       _applyFilters();
// //     });
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text("Created '${newWorkflow.title}'", style: const TextStyle(color: Colors.white)),
// //         backgroundColor: const Color(0xFF6A7B66),
// //       ),
// //     );
// //   }

// //   // --- UI BUILDER ---

// //   @override
// //   Widget build(BuildContext context) {
// //     // Fixed: Switched back to Scaffold to support backgroundColor and floatingActionButton
// //     return Scaffold(
// //       backgroundColor: const Color.fromARGB(90, 25, 28, 25).withValues(alpha: 0.95),
// //       extendBodyBehindAppBar: true,
      
// //       // Create FAB
// //       floatingActionButton: ScaleTransition(
// //         scale: _fabScale,
// //         child: FloatingActionButton.extended(
// //           onPressed: _openCreateWizard,
// //           backgroundColor: Colors.white,
// //           foregroundColor: const Color(0xFF2F3A2F),
// //           elevation: 10,
// //           icon: const Icon(Icons.add_circle_outline),
// //           label: const Text("New Workflow", style: TextStyle(fontWeight: FontWeight.bold)),
// //         ),
// //       ),
// //       body: Stack(
// //         children: [
// //           // Background Doodles
// //           Positioned(
// //             top: 50, right: -50,
// //             child: AnimatedBuilder(
// //               animation: _doodleMoveAnimation,
// //               builder: (context, child) => Transform.translate(
// //                 offset: Offset(0, _doodleMoveAnimation.value),
// //                 child: Opacity(
// //                   opacity: 0.05,
// //                   child: SvgPicture.asset(
// //                     'assets/images/undraw_connected_0xor.svg',
// //                     width: 300,
// //                     colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           SafeArea(
// //             bottom: false,
// //             child: Column(
// //               children: [
// //                 // 1. FIXED APP BAR
// //                 _buildFixedAppBar(),

// //                 // 2. FIXED DASHBOARD HEADER
// //                 Padding(
// //                   padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
// //                   child: _buildDashboardHeader(),
// //                 ),

// //                 // 3. SCROLLABLE CONTENT (Filters + List)
// //                 Expanded(
// //                   child: CustomScrollView(
// //                     controller: _scrollController,
// //                     slivers: [
// //                       // Sticky Search & Filter
// //                       SliverPersistentHeader(
// //                         pinned: true,
// //                         delegate: _StickyFilterDelegate(
// //                           minHeight: 130,
// //                           maxHeight: 130,
// //                           child: _buildFilterSection(),
// //                         ),
// //                       ),

// //                       // List
// //                       SliverPadding(
// //                         padding: const EdgeInsets.only(top: 10),
// //                         sliver: _isLoading 
// //                           ? const SliverFillRemaining(
// //                               child: Center(child: CircularProgressIndicator(color: Colors.white)))
// //                           : _buildWorkflowSliverList(),
// //                       ),
                       
// //                       const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // --- WIDGETS ---

// //   Widget _buildFixedAppBar() {
// //     return Padding(
// //       padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(20),
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //           child: Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               color: Colors.white.withValues(alpha: 0.05),
// //               borderRadius: BorderRadius.circular(20),
// //               border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// //             ),
// //             child: const Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   "Vetto Workflows",
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.w800,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 CircleAvatar(
// //                   radius: 16,
// //                   backgroundColor: Color(0xFFB5A642), // Gold
// //                   child: Text("AC", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12)),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDashboardHeader() {
// //     return SizedBox(
// //       height: 100, 
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           // Text Content
// //           Text(
// //             "Your\nAutomations",
// //             style: TextStyle(
// //               fontSize: 32,
// //               fontWeight: FontWeight.w800,
// //               height: 1.1,
// //               color: Colors.white,
// //               shadows: [
// //                 Shadow(
// //                   color: Colors.black.withValues(alpha: 0.5),
// //                   offset: const Offset(0, 4),
// //                   blurRadius: 15,
// //                 ),
// //               ],
// //             ),
// //           ),
          
// //           // SMALL LOGO
// //           Container(
// //             width: 80,
// //             height: 80,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: const Color(0xFF6A7B66).withValues(alpha: 0.3),
// //                   blurRadius: 20,
// //                   spreadRadius: 5,
// //                 ),
// //               ],
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.all(15.0),
// //               child: Image.asset(
// //                 'assets/images/logo.png', 
// //                 fit: BoxFit.contain,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildFilterSection() {
// //     return ClipRRect(
// //       child: BackdropFilter(
// //         filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
// //           ),
// //           padding: const EdgeInsets.symmetric(vertical: 15),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               // 1. Search Bar (Priority)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 20),
// //                 child: Row(
// //                   children: [
// //                     Expanded(
// //                       child: Container(
// //                         height: 45,
// //                         decoration: BoxDecoration(
// //                           color: Colors.white.withValues(alpha: 0.08),
// //                           borderRadius: BorderRadius.circular(15),
// //                           border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
// //                         ),
// //                         child: TextField(
// //                           controller: _searchController,
// //                           style: const TextStyle(color: Colors.white),
// //                           cursorColor: const Color(0xFFB5A642),
// //                           decoration: InputDecoration(
// //                             filled: false,
// //                             fillColor: Colors.transparent,
// //                             hoverColor: Colors.transparent,
// //                             hintText: "Search workflows...",
// //                             hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
// //                             prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.4), size: 20),
// //                             border: InputBorder.none,
// //                             enabledBorder: InputBorder.none,
// //                             focusedBorder: InputBorder.none,
// //                             contentPadding: const EdgeInsets.symmetric(vertical: 10),
// //                           ),
// //                           onChanged: (val) {
// //                             _searchQuery = val;
// //                             _applyFilters();
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 10),
// //                     // Sort Button
// //                     _buildSortButton(),
// //                   ],
// //                 ),
// //               ),
              
// //               // 2. Chips (The only filters)
// //               SizedBox(
// //                 height: 32,
// //                 child: ListView(
// //                   scrollDirection: Axis.horizontal,
// //                   padding: const EdgeInsets.symmetric(horizontal: 20),
// //                   children: ["All", "Active", "Pending", "Completed", "Error"].map((filter) {
// //                     final isSelected = _currentFilter == filter;
// //                     return Padding(
// //                       padding: const EdgeInsets.only(right: 8),
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           setState(() => _currentFilter = filter);
// //                           _applyFilters();
// //                         },
// //                         child: AnimatedContainer(
// //                           duration: const Duration(milliseconds: 200),
// //                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
// //                           decoration: BoxDecoration(
// //                             color: isSelected ? Colors.white : Colors.transparent,
// //                             borderRadius: BorderRadius.circular(20),
// //                             border: Border.all(
// //                               color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.3),
// //                             ),
// //                           ),
// //                           child: Center(
// //                             child: Text(
// //                               filter,
// //                               style: TextStyle(
// //                                 color: isSelected ? const Color(0xFF2F3A2F) : Colors.white.withValues(alpha: 0.7),
// //                                 fontWeight: FontWeight.w600,
// //                                 fontSize: 12,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSortButton() {
// //     return Container(
// //       height: 45,
// //       width: 45,
// //       decoration: BoxDecoration(
// //         color: Colors.white.withValues(alpha: 0.08),
// //         borderRadius: BorderRadius.circular(15),
// //         border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
// //       ),
// //       child: PopupMenuButton<String>(
// //         icon: const Icon(Icons.sort, color: Colors.white, size: 20),
// //         color: const Color(0xFF2F3A2F),
// //         elevation: 10,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// //         onSelected: (val) {
// //           setState(() => _sortBy = val);
// //           _applyFilters();
// //         },
// //         itemBuilder: (context) => [
// //           "Newest", "Oldest", "Progress", "Priority"
// //         ].map((s) => PopupMenuItem(
// //           value: s,
// //           child: Row(
// //             children: [
// //               Text(s, style: TextStyle(color: _sortBy == s ? const Color(0xFFB5A642) : Colors.white)),
// //               if (_sortBy == s) ...[const Spacer(), const Icon(Icons.check, size: 14, color: Color(0xFFB5A642))]
// //             ],
// //           ),
// //         )).toList(),
// //       ),
// //     );
// //   }

// //   // --- LIST BUILDING ---

// //   Widget _buildWorkflowSliverList() {
// //     if (_displayWorkflows.isEmpty) {
// //       return SliverFillRemaining(
// //         child: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(Icons.folder_off_outlined, size: 60, color: Colors.white.withValues(alpha: 0.1)),
// //               const SizedBox(height: 16),
// //               Text("No workflows found", style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
// //             ],
// //           ),
// //         ),
// //       );
// //     }

// //     return SliverList(
// //       delegate: SliverChildBuilderDelegate(
// //         (context, index) {
// //           final workflow = _displayWorkflows[index];
// //           return TweenAnimationBuilder(
// //             tween: Tween<double>(begin: 0, end: 1),
// //             duration: Duration(milliseconds: 400 + (index * 50).clamp(0, 1000)),
// //             curve: Curves.easeOutCubic,
// //             builder: (context, value, child) {
// //               return Transform.translate(
// //                 offset: Offset(0, 20 * (1 - value)),
// //                 child: Opacity(opacity: value, child: child),
// //               );
// //             },
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
// //               child: _WorkflowCardPro(
// //                 workflow: workflow,
// //                 onTap: () {}, 
// //               ),
// //             ),
// //           );
// //         },
// //         childCount: _displayWorkflows.length,
// //       ),
// //     );
// //   }

// //   // --- WIZARD LOGIC ---

// //   void _openCreateWizard() async {
// //     final result = await showModalBottomSheet<Workflow>(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (context) => const _CreateWorkflowWizard(),
// //     );

// //     if (result != null) {
// //       _handleCreateWorkflow(result);
// //     }
// //   }

// //   // --- MOCK DATA ---
// //   List<Workflow> _generateComplexMockData() {
// //     return [
// //       Workflow(
// //         id: '1',
// //         title: 'Q3 Data Pipeline',
// //         description: 'Ingest CSVs from S3, sanitize, transform to JSON.',
// //         status: WorkflowStatus.active,
// //         priority: WorkflowPriority.high,
// //         progress: 65,
// //         tags: ['Data', 'AWS'],
// //         createdAt: DateTime.now(),
// //         steps: [],
// //         assignees: [const WorkflowUser(id: 'u1', name: 'Alex', avatarUrl: '')],
// //       ),
// //       Workflow(
// //         id: '2',
// //         title: 'Invoice Bot',
// //         description: 'Watch email for "Invoice" subject, parse PDF.',
// //         status: WorkflowStatus.completed,
// //         priority: WorkflowPriority.medium,
// //         progress: 100,
// //         tags: ['Finance'],
// //         createdAt: DateTime.now().subtract(const Duration(days: 2)),
// //         steps: [],
// //         assignees: [],
// //       ),
// //       Workflow(
// //         id: '3',
// //         title: 'Server Health Check',
// //         description: 'Ping API endpoints every 5 mins. Alert on failure.',
// //         status: WorkflowStatus.error,
// //         priority: WorkflowPriority.critical,
// //         progress: 20,
// //         tags: ['DevOps'],
// //         createdAt: DateTime.now().subtract(const Duration(hours: 5)),
// //         steps: [],
// //         assignees: [],
// //       ),
// //     ];
// //   }
// // }

// // // --- 4. WIDGETS: CARD ---

// // class _WorkflowCardPro extends StatelessWidget {
// //   final Workflow workflow;
// //   final VoidCallback onTap;

// //   const _WorkflowCardPro({required this.workflow, required this.onTap});

// //   Color _getStatusColor() {
// //     switch (workflow.status) {
// //       case WorkflowStatus.active: return Colors.white;
// //       case WorkflowStatus.completed: return const Color(0xFF6A7B66); // Sage
// //       case WorkflowStatus.error: return const Color(0xFFD95D5D); // Red
// //       case WorkflowStatus.pending: return const Color(0xFFB5A642); // Gold
// //       case WorkflowStatus.paused: return Colors.grey;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final statusColor = _getStatusColor();

// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(20),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withValues(alpha: 0.2),
// //               blurRadius: 15,
// //               offset: const Offset(0, 5),
// //             ),
// //           ],
// //         ),
// //         child: ClipRRect(
// //           borderRadius: BorderRadius.circular(20),
// //           child: BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //             child: Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Colors.white.withValues(alpha: 0.05),
// //                 borderRadius: BorderRadius.circular(20),
// //                 border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       if (workflow.tags.isNotEmpty)
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white.withValues(alpha: 0.1),
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                           child: Text(
// //                             workflow.tags.first.toUpperCase(),
// //                             style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
// //                           ),
// //                         ),
// //                       const Spacer(),
// //                       Container(
// //                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                         decoration: BoxDecoration(
// //                           color: statusColor.withValues(alpha: 0.15),
// //                           borderRadius: BorderRadius.circular(8),
// //                           border: Border.all(color: statusColor.withValues(alpha: 0.3)),
// //                         ),
// //                         child: Row(
// //                           mainAxisSize: MainAxisSize.min,
// //                           children: [
// //                             Icon(Icons.circle, size: 6, color: statusColor),
// //                             const SizedBox(width: 6),
// //                             Text(
// //                               workflow.status.name.toUpperCase(),
// //                               style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 12),
// //                   Text(
// //                     workflow.title,
// //                     style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     workflow.description,
// //                     maxLines: 2,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13, height: 1.4),
// //                   ),
// //                   const SizedBox(height: 16),
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(4),
// //                     child: LinearProgressIndicator(
// //                       value: workflow.progress / 100,
// //                       backgroundColor: Colors.white.withValues(alpha: 0.1),
// //                       valueColor: AlwaysStoppedAnimation(statusColor),
// //                       minHeight: 4,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // --- 5. STICKY DELEGATE ---

// // class _StickyFilterDelegate extends SliverPersistentHeaderDelegate {
// //   final Widget child;
// //   final double minHeight;
// //   final double maxHeight;

// //   _StickyFilterDelegate({required this.child, required this.minHeight, required this.maxHeight});

// //   @override
// //   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => SizedBox.expand(child: child);
// //   @override
// //   double get maxExtent => maxHeight;
// //   @override
// //   double get minExtent => minHeight;
// //   @override
// //   bool shouldRebuild(_StickyFilterDelegate oldDelegate) => true;
// // }

// // // --- 6. CREATE WIZARD ---

// // class _CreateWorkflowWizard extends StatefulWidget {
// //   const _CreateWorkflowWizard();

// //   @override
// //   State<_CreateWorkflowWizard> createState() => _CreateWorkflowWizardState();
// // }

// // class _CreateWorkflowWizardState extends State<_CreateWorkflowWizard> {
// //   final PageController _pageController = PageController();
// //   int _currentStep = 0;
  
// //   final TextEditingController _titleController = TextEditingController();
// //   final TextEditingController _descController = TextEditingController();
// //   String _selectedTemplate = "Blank Workflow";

// //   @override
// //   Widget build(BuildContext context) {
// //     return ClipRRect(
// //       borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
// //       child: BackdropFilter(
// //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// //         child: Container(
// //           height: MediaQuery.of(context).size.height * 0.85,
// //           decoration: BoxDecoration(
// //             color: const Color.fromARGB(90, 25, 28, 25).withValues(alpha: 0.95),
// //             border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
// //           ),
// //           child: Column(
// //             children: [
// //               Center(
// //                 child: Container(
// //                   margin: const EdgeInsets.only(top: 12),
// //                   width: 40,
// //                   height: 4,
// //                   decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: Row(
// //                   children: [
// //                     const Text("Create Workflow", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
// //                     const Spacer(),
// //                     Text("Step ${_currentStep + 1}/3", style: const TextStyle(color: Color(0xFFB5A642), fontWeight: FontWeight.bold)),
// //                   ],
// //                 ),
// //               ),
// //               Expanded(
// //                 child: PageView(
// //                   controller: _pageController,
// //                   physics: const NeverScrollableScrollPhysics(),
// //                   children: [
// //                     _buildStep1(),
// //                     _buildStep2(),
// //                     _buildStep3(),
// //                   ],
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: Row(
// //                   children: [
// //                     if (_currentStep > 0)
// //                       TextButton(
// //                         onPressed: () {
// //                           _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
// //                           setState(() => _currentStep--);
// //                         },
// //                         child: const Text("Back", style: TextStyle(color: Colors.white54)),
// //                       )
// //                     else
// //                       TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.white54))),
                    
// //                     const Spacer(),
                    
// //                     ElevatedButton(
// //                       onPressed: _handleNext,
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.white,
// //                         foregroundColor: const Color(0xFF2F3A2F),
// //                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// //                       ),
// //                       child: Text(_currentStep == 2 ? "Launch" : "Next"),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _handleNext() {
// //     if (_currentStep < 2) {
// //       _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
// //       setState(() => _currentStep++);
// //     } else {
// //       final newWorkflow = Workflow(
// //         id: DateTime.now().millisecondsSinceEpoch.toString(),
// //         title: _titleController.text.isEmpty ? "Untitled Workflow" : _titleController.text,
// //         description: _descController.text.isEmpty ? "No description" : _descController.text,
// //         status: WorkflowStatus.active,
// //         priority: WorkflowPriority.medium,
// //         progress: 0,
// //         steps: [],
// //         tags: ['New', 'Manual'],
// //         assignees: [],
// //         createdAt: DateTime.now(),
// //       );
      
// //       Navigator.pop(context, newWorkflow); 
// //     }
// //   }

// //   Widget _buildStep1() {
// //     return ListView(
// //       padding: const EdgeInsets.all(20),
// //       children: [
// //         const Text("Basic Info", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 20),
// //         _buildTextField("Workflow Name", "e.g. Monthly Audit", _titleController),
// //         const SizedBox(height: 15),
// //         _buildTextField("Description", "Describe what this does...", _descController, maxLines: 3),
// //       ],
// //     );
// //   }

// //   Widget _buildStep2() {
// //     return ListView(
// //       padding: const EdgeInsets.all(20),
// //       children: [
// //         const Text("Template", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 20),
// //         _buildTemplateCard("Blank Workflow", "Start from scratch", Icons.crop_square),
// //         _buildTemplateCard("Data Pipeline", "ETL basics", Icons.storage),
// //         _buildTemplateCard("Email Automation", "Trigger-based mailing", Icons.mail_outline),
// //       ],
// //     );
// //   }

// //   Widget _buildStep3() {
// //     return ListView(
// //       padding: const EdgeInsets.all(20),
// //       children: [
// //         const Text("Review", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 20),
// //         Container(
// //           padding: const EdgeInsets.all(20),
// //           decoration: BoxDecoration(
// //             color: Colors.white.withValues(alpha: 0.05),
// //             borderRadius: BorderRadius.circular(20),
// //             border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// //           ),
// //           child: Column(
// //             children: [
// //               const Icon(Icons.rocket_launch, size: 60, color: Color(0xFFB5A642)),
// //               const SizedBox(height: 20),
// //               _buildReviewRow("Name", _titleController.text.isEmpty ? "Untitled" : _titleController.text),
// //               _buildReviewRow("Template", _selectedTemplate),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildTextField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
// //         const SizedBox(height: 8),
// //         Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 15),
// //           decoration: BoxDecoration(
// //             color: Colors.black.withValues(alpha: 0.2),
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
// //           ),
// //           child: TextField(
// //             controller: controller,
// //             maxLines: maxLines,
// //             style: const TextStyle(color: Colors.white),
// //             cursorColor: const Color(0xFFB5A642),
// //             decoration: InputDecoration(
// //               hintText: hint,
// //               hintStyle: TextStyle(
// //                 color: Colors.white.withValues(alpha: 0.3),
// //               ),
// //               border: InputBorder.none,
// //               filled: true,
// //               fillColor: Colors.transparent,
// //               enabledBorder: InputBorder.none,
// //               focusedBorder: InputBorder.none,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildTemplateCard(String title, String subtitle, IconData icon) {
// //     final isSelected = _selectedTemplate == title;
// //     return GestureDetector(
// //       onTap: () => setState(() => _selectedTemplate = title),
// //       child: Container(
// //         margin: const EdgeInsets.only(bottom: 10),
// //         decoration: BoxDecoration(
// //           color: isSelected ? const Color(0xFFB5A642).withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
// //           borderRadius: BorderRadius.circular(15),
// //           border: Border.all(color: isSelected ? const Color(0xFFB5A642) : Colors.white.withValues(alpha: 0.1)),
// //         ),
// //         child: ListTile(
// //           leading: Icon(icon, color: isSelected ? const Color(0xFFB5A642) : Colors.white54),
// //           title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// //           subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
// //           trailing: isSelected ? const Icon(Icons.check_circle, color: Color(0xFFB5A642)) : null,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildReviewRow(String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(label, style: const TextStyle(color: Colors.white54)),
// //           Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// // --- 1. MODELS ---

// enum WorkflowStatus { active, pending, completed, error, paused }
// enum WorkflowPriority { low, medium, high, critical }

// class WorkflowUser {
//   final String id;
//   final String name;
//   final String avatarUrl;
  
//   const WorkflowUser({required this.id, required this.name, required this.avatarUrl});
// }

// class WorkflowStep {
//   final String id;
//   final String title;
//   final String description;
//   final bool isCompleted;

//   const WorkflowStep({
//     required this.id, 
//     required this.title, 
//     required this.description, 
//     this.isCompleted = false,
//   });
// }

// class Workflow {
//   final String id;
//   final String title;
//   final String description;
//   final WorkflowStatus status;
//   final WorkflowPriority priority;
//   final double progress;
//   final List<WorkflowStep> steps;
//   final List<String> tags;
//   final List<WorkflowUser> assignees;
//   final DateTime createdAt;

//   const Workflow({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.status,
//     required this.priority,
//     required this.progress,
//     required this.steps,
//     required this.tags,
//     required this.assignees,
//     required this.createdAt,
//   });
// }

// // --- 2. MAIN PAGE ---

// class WorkflowManagerPage extends StatefulWidget {
//   const WorkflowManagerPage({super.key});

//   @override
//   State<WorkflowManagerPage> createState() => _WorkflowManagerPageState();
// }

// class _WorkflowManagerPageState extends State<WorkflowManagerPage> with TickerProviderStateMixin {
//   // --- State ---
//   bool _isLoading = true;
//   String _searchQuery = "";
//   String _currentFilter = "All";
//   String _sortBy = "Newest"; 
  
//   // Data
//   final List<Workflow> _allWorkflows = [];
//   List<Workflow> _displayWorkflows = [];
//   final TextEditingController _searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   // Animations
//   late AnimationController _fabController;
//   late Animation<double> _fabScale;
  
//   // NOTE: Removed bgController/doodleMoveAnimation as we are replacing the 
//   // moving doodles with static, heavy architectural typography per request.

//   @override
//   void initState() {
//     super.initState();
    
//     // FAB Entrance
//     _fabController = AnimationController(
//       vsync: this, 
//       duration: const Duration(milliseconds: 400)
//     );
//     _fabScale = CurvedAnimation(parent: _fabController, curve: Curves.easeOutBack);
//     _fabController.forward();

//     _loadData();
//   }

//   @override
//   void dispose() {
//     _fabController.dispose();
//     _searchController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   // --- DATA LOGIC ---

//   Future<void> _loadData() async {
//     // Simulate network delay to show skeleton
//     await Future.delayed(const Duration(milliseconds: 2000));
//     if (!mounted) return;

//     setState(() {
//       _allWorkflows.clear();
//       _allWorkflows.addAll(_generateComplexMockData());
//       _applyFilters();
//       _isLoading = false;
//     });
//   }

//   void _applyFilters() {
//     List<Workflow> temp = List.from(_allWorkflows);

//     // 1. Search
//     if (_searchQuery.isNotEmpty) {
//       temp = temp.where((w) => 
//         w.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//         w.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//         w.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()))
//       ).toList();
//     }

//     // 2. Status Filter
//     if (_currentFilter != "All") {
//       temp = temp.where((w) => 
//         w.status.name.toLowerCase() == _currentFilter.toLowerCase()
//       ).toList();
//     }

//     // 3. Sorting
//     switch (_sortBy) {
//       case "Newest":
//         temp.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//         break;
//       case "Oldest":
//         temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
//         break;
//       case "Progress":
//         temp.sort((a, b) => b.progress.compareTo(a.progress));
//         break;
//       case "Priority":
//         temp.sort((a, b) => b.priority.index.compareTo(a.priority.index));
//         break;
//     }

//     setState(() {
//       _displayWorkflows = temp;
//     });
//   }

//   void _handleCreateWorkflow(Workflow newWorkflow) {
//     setState(() {
//       _allWorkflows.insert(0, newWorkflow);
//       _applyFilters();
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("Created '${newWorkflow.title}'", style: const TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF333333),
//       ),
//     );
//   }

//   // --- UI BUILDER ---

//   @override
//   Widget build(BuildContext context) {
//     return VettoScaffold(
//       // Updated FAB to match the stark B&W theme
//       floatingActionButton: ScaleTransition(
//         scale: _fabScale,
//         child: FloatingActionButton.extended(
//           onPressed: _openCreateWizard,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black, // Stark contrast
//           elevation: 0, // Flat, minimal
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), // Pill shape
//           icon: const Icon(Icons.add, weight: 600), // Bolder icon
//           label: const Text("NEW WORKFLOW", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5)),
//         ),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // --- 1. PREMIUM DARK BACKGROUND ---
          
//           // A. Base Gradient (Charcoal to Obsidian)
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF121212), // Deep Charcoal
//                   Color(0xFF000000), // Obsidian
//                 ],
//               ),
//             ),
//           ),

//           // B. Radial Spotlight (Top Left Sheen)
//           Positioned(
//             top: -200,
//             left: -200,
//             child: Container(
//               width: 600,
//               height: 600,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: RadialGradient(
//                   colors: [
//                     Colors.white.withValues(alpha:0.07), // Soft sheen
//                     Colors.transparent,
//                   ],
//                   stops: const [0.0, 1.0],
//                 ),
//               ),
//             ),
//           ),

//           // C. Massive Geometric Typography Texture (3% Opacity)
//           // "VETTO" element cropped at bottom right
//           Positioned(
//             bottom: -80,
//             right: -40,
//             child: Text(
//               "VETTO",
//               style: TextStyle(
//                 fontSize: 180,
//                 fontWeight: FontWeight.w900,
//                 color: Colors.white.withValues(alpha:0.03),
//                 letterSpacing: -10.0,
//                 height: 0.8,
//               ),
//             ),
//           ),
//           // "01" element cropped at top left for depth
//           Positioned(
//             top: 100,
//             left: -30,
//             child: Text(
//               "01",
//               style: TextStyle(
//                 fontSize: 250,
//                 fontWeight: FontWeight.w900,
//                 color: Colors.white.withValues(alpha:0.02), // Even fainter
//                 letterSpacing: -15.0,
//               ),
//             ),
//           ),

//           // --- 2. CONTENT ---
//           SafeArea(
//             bottom: false,
//             child: Column(
//               children: [
//                 // A. FIXED APP BAR
//                 _buildFixedAppBar(),

//                 // B. FIXED DASHBOARD HEADER
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
//                   child: _buildDashboardHeader(),
//                 ),

//                 // C. SCROLLABLE CONTENT (Filters + List)
//                 Expanded(
//                   child: CustomScrollView(
//                     controller: _scrollController,
//                     slivers: [
//                       // Sticky Search & Filter
//                       SliverPersistentHeader(
//                         pinned: true,
//                         delegate: _StickyFilterDelegate(
//                           minHeight: 130,
//                           maxHeight: 130,
//                           child: _buildFilterSection(),
//                         ),
//                       ),

//                       // List
//                       SliverPadding(
//                         padding: const EdgeInsets.only(top: 10),
//                         // CHECK LOADING STATE HERE
//                         sliver: _isLoading 
//                           ? _buildSkeletonSliverList() // Show Skeleton
//                           : _buildWorkflowSliverList(), // Show Content
//                       ),
                        
//                       const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- WIDGETS ---

//   Widget _buildFixedAppBar() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Minimalist Label
//           const Text(
//             "VETTO // WORKFLOWS",
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//               color: Colors.white54,
//               letterSpacing: 1.5, // Wide spacing for small caps feel
//             ),
//           ),
//           // Minimalist Avatar
//           Container(
//             padding: const EdgeInsets.all(2),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.white24, width: 1),
//             ),
//             child: const CircleAvatar(
//               radius: 14,
//               backgroundColor: Color(0xFF222222), 
//               child: Text("AC", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDashboardHeader() {
//     return SizedBox(
//       height: 100, 
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           // Text Content - SWISS STYLE: Heavy, Tight Kerning
//           const Text(
//             "YOUR\nAUTOMATIONS",
//             style: TextStyle(
//               fontSize: 36,
//               fontWeight: FontWeight.w900, // Black weight
//               height: 0.9, // Tight line height
//               color: Colors.white,
//               letterSpacing: -1.5, // Tight kerning
//             ),
//           ),
          
//           // SMALL LOGO - Monochrome/Minimal
//           Opacity(
//             opacity: 0.8,
//             child: Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white12, width: 1),
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.white.withValues(alpha:0.05), Colors.transparent],
//                 )
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Image.asset(
//                   'assets/images/logo.png', 
//                   fit: BoxFit.contain,
//                   color: Colors.white, // Force monochrome logo
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterSection() {
//     return ClipRRect(
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Matte blur
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFF121212).withValues(alpha:0.6), // Translucent matte
//             border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha:0.05))),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               // 1. Search Bar (Priority)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withValues(alpha:0.03), // Very subtle fill
//                           borderRadius: BorderRadius.circular(4), // Sharper corners for Swiss vibe
//                           border: Border.all(color: Colors.white.withValues(alpha:0.1)),
//                         ),
//                         child: TextField(
//                           controller: _searchController,
//                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//                           cursorColor: Colors.white,
//                           decoration: InputDecoration(
//                             filled: false,
//                             fillColor: Colors.transparent,
//                             hoverColor: Colors.transparent,
//                             hintText: "SEARCH...",
//                             hintStyle: TextStyle(color: Colors.white.withValues(alpha:0.3), fontSize: 13, letterSpacing: 0.5),
//                             prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha:0.3), size: 18),
//                             border: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             contentPadding: const EdgeInsets.symmetric(vertical: 11),
//                           ),
//                           onChanged: (val) {
//                             _searchQuery = val;
//                             _applyFilters();
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     // Sort Button
//                     _buildSortButton(),
//                   ],
//                 ),
//               ),
              
//               // 2. Chips (The only filters)
//               SizedBox(
//                 height: 32,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   children: ["All", "Active", "Pending", "Completed", "Error"].map((filter) {
//                     final isSelected = _currentFilter == filter;
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() => _currentFilter = filter);
//                           _applyFilters();
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: isSelected ? Colors.white : Colors.transparent,
//                             borderRadius: BorderRadius.circular(4), // Sharper
//                             border: Border.all(
//                               color: isSelected ? Colors.transparent : Colors.white.withValues(alpha:0.15),
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               filter.toUpperCase(),
//                               style: TextStyle(
//                                 color: isSelected ? Colors.black : Colors.white.withValues(alpha:0.5),
//                                 fontWeight: FontWeight.w800, // Heavy weight text
//                                 fontSize: 10,
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSortButton() {
//     return Container(
//       height: 45,
//       width: 45,
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha:0.03),
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(color: Colors.white.withValues(alpha:0.1)),
//       ),
//       child: PopupMenuButton<String>(
//         icon: const Icon(Icons.sort, color: Colors.white, size: 18),
//         color: const Color(0xFF1E1E1E),
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4),
//           side: BorderSide(color: Colors.white.withValues(alpha:0.1))
//         ),
//         onSelected: (val) {
//           setState(() => _sortBy = val);
//           _applyFilters();
//         },
//         itemBuilder: (context) => [
//           "Newest", "Oldest", "Progress", "Priority"
//         ].map((s) => PopupMenuItem(
//           value: s,
//           child: Row(
//             children: [
//               Text(s, style: TextStyle(
//                 color: _sortBy == s ? Colors.white : Colors.white54,
//                 fontWeight: _sortBy == s ? FontWeight.w900 : FontWeight.w400,
//                 fontSize: 13
//               )),
//             ],
//           ),
//         )).toList(),
//       ),
//     );
//   }

//   // --- LIST BUILDING ---

//   // NEW: Skeleton List Builder
//   Widget _buildSkeletonSliverList() {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (context, index) => const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//           child: SkeletonWorkflowCard(),
//         ),
//         childCount: 4, // Show 4 skeleton items
//       ),
//     );
//   }

//   Widget _buildWorkflowSliverList() {
//     if (_displayWorkflows.isEmpty) {
//       return SliverFillRemaining(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.crop_landscape_sharp, size: 40, color: Colors.white.withValues(alpha:0.1)),
//               const SizedBox(height: 16),
//               Text(
//                 "NO WORKFLOWS",
//                 style: TextStyle(
//                   color: Colors.white.withValues(alpha:0.4), 
//                   fontWeight: FontWeight.w800, 
//                   letterSpacing: 1.0,
//                   fontSize: 12
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (context, index) {
//           final workflow = _displayWorkflows[index];
//           return TweenAnimationBuilder(
//             tween: Tween<double>(begin: 0, end: 1),
//             duration: Duration(milliseconds: 400 + (index * 50).clamp(0, 1000)),
//             curve: Curves.easeOutQuart, // Sleeker curve
//             builder: (context, value, child) {
//               return Transform.translate(
//                 offset: Offset(0, 20 * (1 - value)),
//                 child: Opacity(opacity: value, child: child),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               child: _WorkflowCardPro(
//                 workflow: workflow,
//                 onTap: () {}, 
//               ),
//             ),
//           );
//         },
//         childCount: _displayWorkflows.length,
//       ),
//     );
//   }

//   // --- WIZARD LOGIC ---
//   void _openCreateWizard() async {
//     final result = await showModalBottomSheet<Workflow>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => const _CreateWorkflowWizard(),
//     );
//     if (result != null) _handleCreateWorkflow(result);
//   }

//   // --- MOCK DATA ---
//   List<Workflow> _generateComplexMockData() {
//     return [
//       Workflow(
//         id: '1', title: 'Q3 Data Pipeline', description: 'Ingest CSVs from S3, sanitize, transform to JSON.',
//         status: WorkflowStatus.active, priority: WorkflowPriority.high, progress: 65,
//         tags: ['Data', 'AWS'], createdAt: DateTime.now(), steps: [],
//         assignees: [const WorkflowUser(id: 'u1', name: 'Alex', avatarUrl: '')],
//       ),
//       Workflow(
//         id: '2', title: 'Invoice Bot', description: 'Watch email for "Invoice" subject, parse PDF.',
//         status: WorkflowStatus.completed, priority: WorkflowPriority.medium, progress: 100,
//         tags: ['Finance'], createdAt: DateTime.now().subtract(const Duration(days: 2)), steps: [], assignees: [],
//       ),
//       Workflow(
//         id: '3', title: 'Server Health Check', description: 'Ping API endpoints every 5 mins. Alert on failure.',
//         status: WorkflowStatus.error, priority: WorkflowPriority.critical, progress: 20,
//         tags: ['DevOps'], createdAt: DateTime.now().subtract(const Duration(hours: 5)), steps: [], assignees: [],
//       ),
//     ];
//   }
// }

// // --- 4. WIDGETS: CARD ---

// class _WorkflowCardPro extends StatelessWidget {
//   final Workflow workflow;
//   final VoidCallback onTap;

//   const _WorkflowCardPro({required this.workflow, required this.onTap});

//   Color _getStatusColor() {
//     // Colors slightly desaturated for the matte look
//     switch (workflow.status) {
//       case WorkflowStatus.active: return Colors.white;
//       case WorkflowStatus.completed: return const Color(0xFFA5C4A0); 
//       case WorkflowStatus.error: return const Color(0xFFD67B7B);
//       case WorkflowStatus.pending: return const Color(0xFFD4C880);
//       case WorkflowStatus.paused: return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final statusColor = _getStatusColor();
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         // Removed heavy drop shadow for a flatter, cleaner look
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4), // Square aesthetic
//           border: Border.all(color: Colors.white.withValues(alpha:0.05)),
//           color: Colors.transparent, 
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(4),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Slight frost
//             child: Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white.withValues(alpha:0.03), // 3% Fill
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       // Tag - Minimalist
//                       if (workflow.tags.isNotEmpty)
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white24),
//                           ),
//                           child: Text(
//                             workflow.tags.first.toUpperCase(),
//                             style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.5),
//                           ),
//                         ),
//                       const Spacer(),
//                       // Status Indicator - Just text and a dot
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
//                           const SizedBox(width: 8),
//                           Text(
//                             workflow.status.name.toUpperCase(),
//                             style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     workflow.title,
//                     style: const TextStyle(
//                       color: Colors.white, 
//                       fontSize: 20, 
//                       fontWeight: FontWeight.w800, // Swiss Bold
//                       letterSpacing: -0.5
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     workflow.description,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(color: Colors.white.withValues(alpha:0.5), fontSize: 13, height: 1.5, fontWeight: FontWeight.w400),
//                   ),
//                   const SizedBox(height: 24),
//                   // Progress Bar - Ultra thin
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(0),
//                     child: LinearProgressIndicator(
//                       value: workflow.progress / 100,
//                       backgroundColor: Colors.white.withValues(alpha:0.1),
//                       valueColor: AlwaysStoppedAnimation(statusColor),
//                       minHeight: 2, // Ultra thin
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // --- 5. NEW: SKELETON CARD ---
// class SkeletonWorkflowCard extends StatefulWidget {
//   const SkeletonWorkflowCard({super.key});

//   @override
//   State<SkeletonWorkflowCard> createState() => _SkeletonWorkflowCardState();
// }

// class _SkeletonWorkflowCardState extends State<SkeletonWorkflowCard> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Color?> _colorAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat(reverse: true);

//     _colorAnimation = ColorTween(
//       begin: Colors.white.withValues(alpha:0.02),
//       end: Colors.white.withValues(alpha:0.06),
//     ).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Container(
//           height: 160,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.white.withValues(alpha:0.05)),
//           ),
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 60, height: 16,
//                     color: _colorAnimation.value,
//                   ),
//                   Container(
//                     width: 80, height: 16,
//                     color: _colorAnimation.value,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               Container(
//                 width: 200, height: 24,
//                 color: _colorAnimation.value,
//               ),
//               const SizedBox(height: 12),
//               Container(
//                 width: double.infinity, height: 12,
//                 color: _colorAnimation.value,
//               ),
//               const Spacer(),
//               Container(
//                 width: double.infinity, height: 2,
//                 color: _colorAnimation.value,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // --- 6. STICKY DELEGATE & WIZARD ---

// class _StickyFilterDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double minHeight;
//   final double maxHeight;

//   _StickyFilterDelegate({required this.child, required this.minHeight, required this.maxHeight});

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => SizedBox.expand(child: child);
//   @override
//   double get maxExtent => maxHeight;
//   @override
//   double get minExtent => minHeight;
//   @override
//   bool shouldRebuild(_StickyFilterDelegate oldDelegate) => true;
// }

// class _CreateWorkflowWizard extends StatefulWidget {
//   const _CreateWorkflowWizard();

//   @override
//   State<_CreateWorkflowWizard> createState() => _CreateWorkflowWizardState();
// }

// class _CreateWorkflowWizardState extends State<_CreateWorkflowWizard> {
//   // ... (Keeping exact same Wizard Logic as provided) ...
//   final PageController _pageController = PageController();
//   int _currentStep = 0;
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descController = TextEditingController();
//   String _selectedTemplate = "Blank Workflow";

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.vertical(top: Radius.circular(0)), // Sharp top
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.85,
//           decoration: BoxDecoration(
//             color: const Color(0xFF121212).withValues(alpha:0.95), // Deep charcoal
//             border: Border(top: BorderSide(color: Colors.white.withValues(alpha:0.1))),
//           ),
//           child: Column(
//             children: [
//               Center(child: Container(margin: const EdgeInsets.only(top: 12), width: 40, height: 2, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(0)))),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Row(children: [const Text("CREATE WORKFLOW", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.0)), const Spacer(), Text("Step ${_currentStep + 1}/3", style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold))]),
//               ),
//               Expanded(
//                 child: PageView(
//                   controller: _pageController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [_buildStep1(), _buildStep2(), _buildStep3()],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Row(
//                   children: [
//                     if (_currentStep > 0)
//                       TextButton(onPressed: () { _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease); setState(() => _currentStep--); }, child: const Text("BACK", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12)))
//                     else
//                       TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12))),
//                     const Spacer(),
//                     ElevatedButton(
//                       onPressed: _handleNext,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white, 
//                         foregroundColor: Colors.black, 
//                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), 
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
//                         elevation: 0
//                       ),
//                       child: Text(_currentStep == 2 ? "LAUNCH" : "NEXT", style: const TextStyle(fontWeight: FontWeight.w900)),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _handleNext() {
//     if (_currentStep < 2) {
//       _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
//       setState(() => _currentStep++);
//     } else {
//       Navigator.pop(context, Workflow(id: DateTime.now().millisecondsSinceEpoch.toString(), title: _titleController.text.isEmpty ? "Untitled" : _titleController.text, description: _descController.text.isEmpty ? "No desc" : _descController.text, status: WorkflowStatus.active, priority: WorkflowPriority.medium, progress: 0, steps: [], tags: ['New'], assignees: [], createdAt: DateTime.now())); 
//     }
//   }

//   Widget _buildStep1() => ListView(padding: const EdgeInsets.all(20), children: [const Text("BASIC INFO", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1.0)), const SizedBox(height: 30), _buildTextField("NAME", "Workflow Name", _titleController), const SizedBox(height: 25), _buildTextField("DESCRIPTION", "Description...", _descController, maxLines: 3)]);
//   Widget _buildStep2() => ListView(padding: const EdgeInsets.all(20), children: [const Text("TEMPLATE", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1.0)), const SizedBox(height: 30), _buildTemplateCard("Blank Workflow", "Start from scratch", Icons.crop_square_sharp), _buildTemplateCard("Data Pipeline", "ETL Process", Icons.storage_sharp)]);
//   Widget _buildStep3() => ListView(padding: const EdgeInsets.all(20), children: [const Text("REVIEW", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1.0)), const SizedBox(height: 40), const Icon(Icons.rocket_launch, size: 60, color: Colors.white), const SizedBox(height: 20), Center(child: Text("READY TO LAUNCH", style: TextStyle(color: Colors.white.withValues(alpha:0.7), fontWeight: FontWeight.bold, letterSpacing: 1.0)))]);
  
//   Widget _buildTextField(String label, String hint, TextEditingController c, {int maxLines = 1}) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)), const SizedBox(height: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.05), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white.withValues(alpha:0.1))), child: TextField(controller: c, maxLines: maxLines, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: Colors.white.withValues(alpha:0.3)), border: InputBorder.none)))]);
//   Widget _buildTemplateCard(String t, String s, IconData i) => GestureDetector(onTap: () => setState(() => _selectedTemplate = t), child: Container(margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: _selectedTemplate == t ? Colors.white : Colors.white.withValues(alpha:0.05), borderRadius: BorderRadius.circular(4), border: Border.all(color: _selectedTemplate == t ? Colors.white : Colors.white.withValues(alpha:0.1))), child: ListTile(leading: Icon(i, color: _selectedTemplate == t ? Colors.black : Colors.white), title: Text(t, style: TextStyle(color: _selectedTemplate == t ? Colors.black : Colors.white, fontWeight: FontWeight.bold)), subtitle: Text(s, style: TextStyle(color: _selectedTemplate == t ? Colors.black54 : Colors.white54)))));
// }


import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:vetto_ai/widgets/vetto_scaffold.dart';

// --- 1. MODELS ---

enum WorkflowStatus { active, pending, completed, error, paused }
enum WorkflowPriority { low, medium, high, critical }

class WorkflowUser {
  final String id;
  final String name;
  final String avatarUrl;
  
  const WorkflowUser({required this.id, required this.name, required this.avatarUrl});
}

class WorkflowStep {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const WorkflowStep({
    required this.id, 
    required this.title, 
    required this.description, 
    this.isCompleted = false,
  });
}

class Workflow {
  final String id;
  final String title;
  final String description;
  final WorkflowStatus status;
  final WorkflowPriority priority;
  final double progress;
  final List<WorkflowStep> steps;
  final List<String> tags;
  final List<WorkflowUser> assignees;
  final DateTime createdAt;

  const Workflow({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.progress,
    required this.steps,
    required this.tags,
    required this.assignees,
    required this.createdAt,
  });
}

// --- 2. MAIN PAGE ---

class WorkflowManagerPage extends StatefulWidget {
  const WorkflowManagerPage({super.key});

  @override
  State<WorkflowManagerPage> createState() => _WorkflowManagerPageState();
}

class _WorkflowManagerPageState extends State<WorkflowManagerPage> with TickerProviderStateMixin {
  // --- State ---
  bool _isLoading = true;
  String _searchQuery = "";
  String _currentFilter = "All";
  String _sortBy = "Newest"; 
  
  // Data
  final List<Workflow> _allWorkflows = [];
  List<Workflow> _displayWorkflows = [];
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Animations
  late AnimationController _fabController;
  late Animation<double> _fabScale;
  
  // NOTE: Removed bgController/doodleMoveAnimation as we are replacing the 
  // moving doodles with static, heavy architectural typography per request.

  @override
  void initState() {
    super.initState();
    
    // FAB Entrance
    _fabController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 400)
    );
    _fabScale = CurvedAnimation(parent: _fabController, curve: Curves.easeOutBack);
    _fabController.forward();

    _loadData();
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // --- DATA LOGIC ---

  Future<void> _loadData() async {
    // Simulate network delay to show skeleton
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    setState(() {
      _allWorkflows.clear();
      _allWorkflows.addAll(_generateComplexMockData());
      _applyFilters();
      _isLoading = false;
    });
  }

  void _applyFilters() {
    List<Workflow> temp = List.from(_allWorkflows);

    // 1. Search
    if (_searchQuery.isNotEmpty) {
      temp = temp.where((w) => 
        w.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        w.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        w.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()))
      ).toList();
    }

    // 2. Status Filter
    if (_currentFilter != "All") {
      temp = temp.where((w) => 
        w.status.name.toLowerCase() == _currentFilter.toLowerCase()
      ).toList();
    }

    // 3. Sorting
    switch (_sortBy) {
      case "Newest":
        temp.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case "Oldest":
        temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case "Progress":
        temp.sort((a, b) => b.progress.compareTo(a.progress));
        break;
      case "Priority":
        temp.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
    }

    setState(() {
      _displayWorkflows = temp;
    });
  }

  void _handleCreateWorkflow(Workflow newWorkflow) {
    setState(() {
      _allWorkflows.insert(0, newWorkflow);
      _applyFilters();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Created '${newWorkflow.title}'", style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF333333),
      ),
    );
  }

  // --- UI BUILDER ---

  @override
  Widget build(BuildContext context) {
    return VettoScaffold(
      // FIXED: Wrapped FAB in Padding to lift it above the Navbar
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90), // Clears the Navbar
        child: ScaleTransition(
          scale: _fabScale,
          child: FloatingActionButton.extended(
            onPressed: _openCreateWizard,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black, // Stark contrast
            elevation: 0, // Flat, minimal
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), // Pill shape
            icon: const Icon(Icons.add, weight: 600), // Bolder icon
            label: const Text("NEW WORKFLOW", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5)),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- 1. PREMIUM DARK BACKGROUND ---
          
          // A. Base Gradient (Charcoal to Obsidian)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF121212), // Deep Charcoal
                  Color(0xFF000000), // Obsidian
                ],
              ),
            ),
          ),

          // B. Radial Spotlight (Top Left Sheen)
          Positioned(
            top: -200,
            left: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.07), // Soft sheen
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // C. Massive Geometric Typography Texture (3% Opacity)
          // "VETTO" element cropped at bottom right
          Positioned(
            bottom: -80,
            right: -40,
            child: Text(
              "VETTO",
              style: TextStyle(
                fontSize: 180,
                fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.03),
                letterSpacing: -10.0,
                height: 0.8,
              ),
            ),
          ),
          // "01" element cropped at top left for depth
          Positioned(
            top: 100,
            left: -30,
            child: Text(
              "01",
              style: TextStyle(
                fontSize: 250,
                fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.02), // Even fainter
                letterSpacing: -15.0,
              ),
            ),
          ),

          // --- 2. CONTENT ---
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // A. FIXED APP BAR
                _buildFixedAppBar(),

                // B. FIXED DASHBOARD HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: _buildDashboardHeader(),
                ),

                // C. SCROLLABLE CONTENT (Filters + List)
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      // Sticky Search & Filter
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _StickyFilterDelegate(
                          minHeight: 130,
                          maxHeight: 130,
                          child: _buildFilterSection(),
                        ),
                      ),

                      // List
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 10),
                        // CHECK LOADING STATE HERE
                        sliver: _isLoading 
                          ? _buildSkeletonSliverList() // Show Skeleton
                          : _buildWorkflowSliverList(), // Show Content
                      ),
                        
                      // FIXED: Increased bottom padding to ensure list items scroll above Navbar
                      const SliverPadding(padding: EdgeInsets.only(bottom: 160)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildFixedAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Minimalist Label
          const Text(
            "VETTO // WORKFLOWS",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white54,
              letterSpacing: 1.5, // Wide spacing for small caps feel
            ),
          ),
          // Minimalist Avatar
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFF222222), 
              child: Text("AC", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardHeader() {
    return SizedBox(
      height: 100, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text Content - SWISS STYLE: Heavy, Tight Kerning
          const Text(
            "YOUR\nAUTOMATIONS",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900, // Black weight
              height: 0.9, // Tight line height
              color: Colors.white,
              letterSpacing: -1.5, // Tight kerning
            ),
          ),
          
          // SMALL LOGO - Monochrome/Minimal
          Opacity(
            opacity: 0.8,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white12, width: 1),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/images/logo.png', 
                  fit: BoxFit.contain,
                  color: Colors.white, // Force monochrome logo
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Matte blur
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF121212).withValues(alpha: 0.6), // Translucent matte
            border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 1. Search Bar (Priority)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.03), // Very subtle fill
                          borderRadius: BorderRadius.circular(4), // Sharper corners for Swiss vibe
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            filled: false,
                            fillColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            hintText: "SEARCH...",
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 13, letterSpacing: 0.5),
                            prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.3), size: 18),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 11),
                          ),
                          onChanged: (val) {
                            _searchQuery = val;
                            _applyFilters();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Sort Button
                    _buildSortButton(),
                  ],
                ),
              ),
              
              // 2. Chips (The only filters)
              SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: ["All", "Active", "Pending", "Completed", "Error"].map((filter) {
                    final isSelected = _currentFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _currentFilter = filter);
                          _applyFilters();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(4), // Sharper
                            border: Border.all(
                              color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              filter.toUpperCase(),
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white.withValues(alpha: 0.5),
                                fontWeight: FontWeight.w800, // Heavy weight text
                                fontSize: 10,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortButton() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.sort, color: Colors.white, size: 18),
        color: const Color(0xFF1E1E1E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.1))
        ),
        onSelected: (val) {
          setState(() => _sortBy = val);
          _applyFilters();
        },
        itemBuilder: (context) => [
          "Newest", "Oldest", "Progress", "Priority"
        ].map((s) => PopupMenuItem(
          value: s,
          child: Row(
            children: [
              Text(s, style: TextStyle(
                color: _sortBy == s ? Colors.white : Colors.white54,
                fontWeight: _sortBy == s ? FontWeight.w900 : FontWeight.w400,
                fontSize: 13
              )),
            ],
          ),
        )).toList(),
      ),
    );
  }

  // --- LIST BUILDING ---

  // NEW: Skeleton List Builder
  Widget _buildSkeletonSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: SkeletonWorkflowCard(),
        ),
        childCount: 4, // Show 4 skeleton items
      ),
    );
  }

  Widget _buildWorkflowSliverList() {
    if (_displayWorkflows.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.crop_landscape_sharp, size: 40, color: Colors.white.withValues(alpha: 0.1)),
              const SizedBox(height: 16),
              Text(
                "NO WORKFLOWS",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4), 
                  fontWeight: FontWeight.w800, 
                  letterSpacing: 1.0,
                  fontSize: 12
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final workflow = _displayWorkflows[index];
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 400 + (index * 50).clamp(0, 1000)),
            curve: Curves.easeOutQuart, // Sleeker curve
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: _WorkflowCardPro(
                workflow: workflow,
                onTap: () {}, 
              ),
            ),
          );
        },
        childCount: _displayWorkflows.length,
      ),
    );
  }

  // --- WIZARD LOGIC ---
  void _openCreateWizard() async {
    final result = await showModalBottomSheet<Workflow>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _CreateWorkflowWizard(),
    );
    if (result != null) _handleCreateWorkflow(result);
  }

  // --- MOCK DATA ---
  List<Workflow> _generateComplexMockData() {
    return [
      Workflow(
        id: '1', title: 'Q3 Data Pipeline', description: 'Ingest CSVs from S3, sanitize, transform to JSON.',
        status: WorkflowStatus.active, priority: WorkflowPriority.high, progress: 65,
        tags: ['Data', 'AWS'], createdAt: DateTime.now(), steps: [],
        assignees: [const WorkflowUser(id: 'u1', name: 'Alex', avatarUrl: '')],
      ),
      Workflow(
        id: '2', title: 'Invoice Bot', description: 'Watch email for "Invoice" subject, parse PDF.',
        status: WorkflowStatus.completed, priority: WorkflowPriority.medium, progress: 100,
        tags: ['Finance'], createdAt: DateTime.now().subtract(const Duration(days: 2)), steps: [], assignees: [],
      ),
      Workflow(
        id: '3', title: 'Server Health Check', description: 'Ping API endpoints every 5 mins. Alert on failure.',
        status: WorkflowStatus.error, priority: WorkflowPriority.critical, progress: 20,
        tags: ['DevOps'], createdAt: DateTime.now().subtract(const Duration(hours: 5)), steps: [], assignees: [],
      ),
    ];
  }
}

// --- 4. WIDGETS: CARD ---

class _WorkflowCardPro extends StatelessWidget {
  final Workflow workflow;
  final VoidCallback onTap;

  const _WorkflowCardPro({required this.workflow, required this.onTap});

  Color _getStatusColor() {
    // Colors slightly desaturated for the matte look
    switch (workflow.status) {
      case WorkflowStatus.active: return Colors.white;
      case WorkflowStatus.completed: return const Color(0xFFA5C4A0); 
      case WorkflowStatus.error: return const Color(0xFFD67B7B);
      case WorkflowStatus.pending: return const Color(0xFFD4C880);
      case WorkflowStatus.paused: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Removed heavy drop shadow for a flatter, cleaner look
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), // Square aesthetic
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          color: Colors.transparent, 
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Slight frost
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03), // 3% Fill
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Tag - Minimalist
                      if (workflow.tags.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Text(
                            workflow.tags.first.toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                          ),
                        ),
                      const Spacer(),
                      // Status Indicator - Just text and a dot
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                          const SizedBox(width: 8),
                          Text(
                            workflow.status.name.toUpperCase(),
                            style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    workflow.title,
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 20, 
                      fontWeight: FontWeight.w800, // Swiss Bold
                      letterSpacing: -0.5
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    workflow.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13, height: 1.5, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 24),
                  // Progress Bar - Ultra thin
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: LinearProgressIndicator(
                      value: workflow.progress / 100,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation(statusColor),
                      minHeight: 2, // Ultra thin
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- 5. NEW: SKELETON CARD ---
class SkeletonWorkflowCard extends StatefulWidget {
  const SkeletonWorkflowCard({super.key});

  @override
  State<SkeletonWorkflowCard> createState() => _SkeletonWorkflowCardState();
}

class _SkeletonWorkflowCardState extends State<SkeletonWorkflowCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.white.withValues(alpha: 0.02),
      end: Colors.white.withValues(alpha: 0.06),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60, height: 16,
                    color: _colorAnimation.value,
                  ),
                  Container(
                    width: 80, height: 16,
                    color: _colorAnimation.value,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: 200, height: 24,
                color: _colorAnimation.value,
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity, height: 12,
                color: _colorAnimation.value,
              ),
              const Spacer(),
              Container(
                width: double.infinity, height: 2,
                color: _colorAnimation.value,
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- 6. STICKY DELEGATE & WIZARD ---

class _StickyFilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _StickyFilterDelegate({required this.child, required this.minHeight, required this.maxHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => SizedBox.expand(child: child);
  @override
  double get maxExtent => maxHeight;
  @override
  double get minExtent => minHeight;
  @override
  bool shouldRebuild(_StickyFilterDelegate oldDelegate) => true;
}

class _CreateWorkflowWizard extends StatefulWidget {
  const _CreateWorkflowWizard();

  @override
  State<_CreateWorkflowWizard> createState() => _CreateWorkflowWizardState();
}

class _CreateWorkflowWizardState extends State<_CreateWorkflowWizard> {
  // ... (Keeping exact same Wizard Logic as provided) ...
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _selectedTemplate = "Blank Workflow";

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(0)), // Sharp top
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: const Color(0xFF121212).withValues(alpha: 0.95), // Deep charcoal
            border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          ),
          child: Column(
            children: [
              Center(child: Container(margin: const EdgeInsets.only(top: 12), width: 40, height: 2, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(0)))),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [const Text("CREATE WORKFLOW", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.0)), const Spacer(), Text("Step ${_currentStep + 1}/3", style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold))]),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [_buildStep1(), _buildStep2(), _buildStep3()],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      TextButton(onPressed: () { _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease); setState(() => _currentStep--); }, child: const Text("BACK", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12)))
                    else
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12))),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _handleNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, 
                        foregroundColor: Colors.black, 
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), 
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        elevation: 0
                      ),
                      child: Text(_currentStep == 2 ? "LAUNCH" : "NEXT", style: const TextStyle(fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    if (_currentStep < 2) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setState(() => _currentStep++);
    } else {
      Navigator.pop(context, Workflow(id: DateTime.now().millisecondsSinceEpoch.toString(), title: _titleController.text.isEmpty ? "Untitled" : _titleController.text, description: _descController.text.isEmpty ? "No desc" : _descController.text, status: WorkflowStatus.active, priority: WorkflowPriority.medium, progress: 0, steps: [], tags: ['New'], assignees: [], createdAt: DateTime.now())); 
    }
  }

  Widget _buildStep1() => ListView(padding: const EdgeInsets.all(20), children: [const Text("BASIC INFO", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1.0)), const SizedBox(height: 30), _buildTextField("NAME", "Workflow Name", _titleController), const SizedBox(height: 25), _buildTextField("DESCRIPTION", "Description...", _descController, maxLines: 3)]);
  Widget _buildStep2() => ListView(padding: const EdgeInsets.all(20), children: [const Text("TEMPLATE", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1.0)), const SizedBox(height: 30), _buildTemplateCard("Blank Workflow", "Start from scratch", Icons.crop_square_sharp), _buildTemplateCard("Data Pipeline", "ETL Process", Icons.storage_sharp)]);
  Widget _buildStep3() => ListView(padding: const EdgeInsets.all(20), children: [const Text("REVIEW", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1.0)), const SizedBox(height: 40), const Icon(Icons.rocket_launch, size: 60, color: Colors.white), const SizedBox(height: 20), Center(child: Text("READY TO LAUNCH", style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontWeight: FontWeight.bold, letterSpacing: 1.0)))]);
  
  Widget _buildTextField(String label, String hint, TextEditingController c, {int maxLines = 1}) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)), const SizedBox(height: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white.withValues(alpha: 0.1))), child: TextField(controller: c, maxLines: maxLines, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)), border: InputBorder.none)))]);
  Widget _buildTemplateCard(String t, String s, IconData i) => GestureDetector(onTap: () => setState(() => _selectedTemplate = t), child: Container(margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: _selectedTemplate == t ? Colors.white : Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(4), border: Border.all(color: _selectedTemplate == t ? Colors.white : Colors.white.withValues(alpha: 0.1))), child: ListTile(leading: Icon(i, color: _selectedTemplate == t ? Colors.black : Colors.white), title: Text(t, style: TextStyle(color: _selectedTemplate == t ? Colors.black : Colors.white, fontWeight: FontWeight.bold)), subtitle: Text(s, style: TextStyle(color: _selectedTemplate == t ? Colors.black54 : Colors.white54)))));
}