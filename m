Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848664;
	b=vdIUcJOrY/LjPQeA/RKALudF+Xu0aZpWh/+JPXpEVjJ9hV3LrnL1P7DJg40w8zMJ6ja9
	 kxjN57FtdyVsVPRo9eLs9LBYuhPBzD5bm22p9OFIDDEfP5L9HVtWDxKF/F61g0ynWx3sV
	 jD/V+w8Wp4Ad1l/79MaKS1Ecqm1gyUFBa2GLLHP7THY7EW6BnoRjykwQV10I0qta/My79
	 NXXh2aBPYUJBPT+13c00tQiJrETOL1JGg7ir2TwsqsBFrRLSMXymEynY54niLrdBAqQzW
	 RzlEaHeuueTCW+xuxzmss0LGUnPPYxw3RSJ5/MRwdXmTPqVrWuEc87Vrh+OtdcHiKHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848664;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/an421p7PrZdRlRN9E7wie2qhgDAbZPyhEYzchtX3AA=;
	b=cw0/dneC4LJkhei+aKo9m5zspZz20vVueFMPGfbDR9YXmE/KC7srPVUv1qJTe/tpAjIb
	 K/6rU34sYxbWEOxKwPHaS4uduMTgHdXaAg9loPojw6rqb42v6k9zqHYuHAyw1IjWKZ5OS
	 VwDI4fT9rDCqY2xjWO77xlXoB0WLHUyl+UDAIKbByFcZkD0dXMKS+2OsPoEUJ8WfQpWim
	 VgraAABovgive5OWAZOtc90dTWP6V5qUDk6V5pvMO5h0CeS1WQrGMmorr9zPClgdx/Anc
	 /YbBmBG6LVgPgbDjWJ3nYgdU1HthErUzfwUqxTKpGQLZl/4e/UK6gHIwPwoE5t2d98A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hKYJcB9i;
	arc=none smtp.remote-ip=95.215.58.27
Received: from mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E725606A31D
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E725606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hKYJcB9i
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=i/OUM9PNUagk4XHXdM7pT/DcHVgeaZ4CI4wZFXPCZig=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848660; v=1; x=1793453460;
 b=hKYJcB9iOZn78z1yDZOIH8elvYB4shVZob35+X1i7UAiBvFiPpPiY2gc8XdCbA0gdmDE64bx
 krHejCpKX05rgoSFkJIHvdXWGDhmpOS2UJsrgH82ZrVErXLA36jw0D5mS/TybhAbTKkuv8xGATt
 g1PbYeb07+eAVnnvVUPRjLKI=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id ed3cac74537d0cb9;
	Sat, 24 Oct 2026 13:31:00 +0000
X-Mizu-Trace-ID: ed3cac74537d0cb9
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 04/15] net: add softnet_data.in_net_rx_action
Date: Sat, 24 Oct 2026 21:30:28 +0800
Message-Id: <48109a783a5d53aba426fac9f3aabf3b447b5bb5.1792847032.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792847031.git.wen.yang@linux.dev>
References: <cover.1792847031.git.wen.yang@linux.dev>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

commit c59647c0dc679008886756a888368da1c6d4ccd3 upstream.

We want to make two optimizations in napi_schedule_rps() and
____napi_schedule() which require to know if these helpers are
called from net_rx_action(), instead of being called from
other contexts.

sd.in_net_rx_action is only read/written by the owning cpu.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/linux/netdevice.h | 1 +
 net/core/dev.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e97967ca2760..987177cebe7c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3161,6 +3161,7 @@ struct softnet_data {
 #ifdef CONFIG_RPS
 	struct softnet_data	*rps_ipi_list;
 #endif
+	bool			in_net_rx_action;
 #ifdef CONFIG_NET_FLOW_LIMIT
 	struct sd_flow_limit __rcu *flow_limit;
 #endif
diff --git a/net/core/dev.c b/net/core/dev.c
index 36dbb86496ec..a46caebb06f7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6795,6 +6795,7 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
+	sd->in_net_rx_action = true;
 	local_irq_disable();
 	list_splice_init(&sd->poll_list, &list);
 	local_irq_enable();
@@ -6805,6 +6806,7 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 		skb_defer_free_flush(sd);
 
 		if (list_empty(&list)) {
+			sd->in_net_rx_action = false;
 			if (!sd_has_rps_ipi_waiting(sd) && list_empty(&repoll))
 				goto end;
 			break;
@@ -6831,6 +6833,8 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 	list_splice(&list, &sd->poll_list);
 	if (!list_empty(&sd->poll_list))
 		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	else
+		sd->in_net_rx_action = false;
 
 	net_rps_action_and_irq_enable(sd);
 end:;
-- 
2.25.1

