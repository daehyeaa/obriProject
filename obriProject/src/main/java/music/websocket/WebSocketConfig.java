package music.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker	// 웹소켓 메시지 다룰수 있게 허용
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
	
	@Override
	public void configureMessageBroker(final MessageBrokerRegistry registry) {
		// "/topic"의 경로로 시작하면, 메시지 그대로 전달
        registry.enableSimpleBroker("/topic");
        // "/ws"의 경로로 시작하면, 중간에 가공 후 메시지 전달
        registry.setApplicationDestinationPrefixes("/ws");

    }

    @Override
    public void registerStompEndpoints(final StompEndpointRegistry registry) {
        // connection을 맺는 경로("/our-websocket") 설정
    	registry.addEndpoint("/our-websocket").withSockJS();
    }
}
