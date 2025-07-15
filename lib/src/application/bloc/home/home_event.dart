class HomeEvent {}

class OnInit extends HomeEvent{}

class SearchFieldChange extends HomeEvent{
  String searchValue;
  SearchFieldChange(this.searchValue);
}