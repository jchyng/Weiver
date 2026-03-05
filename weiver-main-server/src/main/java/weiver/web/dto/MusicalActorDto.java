package weiver.web.dto;

import weiver.domain.entity.Musical;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
@AllArgsConstructor
public class MusicalActorDto {
    private Musical musical;
    private List<ActorsByRoleDto> actorsByRoleDtoList;
}
