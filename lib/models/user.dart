class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime? lastActive;
  final bool isOnline;
  final UserStats stats;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.lastActive,
    this.isOnline = false,
    required this.stats,
  });
  
  User copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    bool? isOnline,
    UserStats? stats,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastActive: lastActive,
      isOnline: isOnline ?? this.isOnline,
      stats: stats ?? this.stats,
    );
  }
}

class UserStats {
  final int workflowCompletions;
  final int aiSuggestions;
  final int activeTasks;
  final int templatesCreated;
  
  const UserStats({
    this.workflowCompletions = 0,
    this.aiSuggestions = 0,
    this.activeTasks = 0,
    this.templatesCreated = 0,
  });
  
  UserStats copyWith({
    int? workflowCompletions,
    int? aiSuggestions,
    int? activeTasks,
    int? templatesCreated,
  }) {
    return UserStats(
      workflowCompletions: workflowCompletions ?? this.workflowCompletions,
      aiSuggestions: aiSuggestions ?? this.aiSuggestions,
      activeTasks: activeTasks ?? this.activeTasks,
      templatesCreated: templatesCreated ?? this.templatesCreated,
    );
  }
}