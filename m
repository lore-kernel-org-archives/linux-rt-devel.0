Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848700;
	b=HKCXEmtzm3wqXpozSedng5lKQ2UXA66yp+0GZUYAIhG3g/s8EYX2RwgtAJWo3TGlqw1f
	 kwU3jqXNAmYv0jj6Bq4YCeSxYzbU0KLrFpuStOOm4iAvHJtU4rUudGj0tPdS8tstsbid3
	 l+CqI3Ny8MPXRNDV5clQa9/dnkMXoiRfzQEnm9qMf6brEoZ8/HW2lDbLcLAkmwFqjlm/T
	 IHMc4i5CEAxLMYLad6mxV2jH+2PMyHFFqeN/R0SUeX65U3HpRwmgzbOqMxCDuO2lvHk6f
	 T0zpw1uvIbZNSNfUjNdtppaVNnhtjjNPCzNV4LkiVRnOaIowHaOM0ksQjQuy4RPB8Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848700;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QNQRtTftC0I2JbB0UnI6wUqB2KlbBmFzXpVgkrwvYtY=;
	b=2YZLxKRsKp20OB2i+NcRwiIXQT17oEY8pt9sZd2WqLLVhAd01eQt7pqRcnXNsnaxt6/x
	 AiMHwry72MmspxID8BlKBDuvbO1RikZofRAbZEQhMUaW05R94FEufKSISrRh27go3w3Mw
	 JqMaOv7ZklDgUFjU4o00IbP2oKmnOzFTg7pKhX/IiDHY+p8iZqgiCSB3dIaRCaYsKr/dd
	 mk99oCEpqvzGv+mY+ppsQ5imn8z4rhF3dbdc4kRV6oPlMM2zaMtq47Ipx3jKpNoJ2HRta
	 RRI+t0R2wli8K0HaHHnKCPIGaA/OkJ37FhFTiBOe9KxIQTu0UJ8+ijDWzbq7b9Y6crg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HiL0z4X+;
	arc=none smtp.remote-ip=91.218.175.52
Received: from mta0.migadu.com (out-52.mta0.migadu.com [91.218.175.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7E606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BC7E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HiL0z4X+
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=4aoRt+mSadCNqhio833UPcDFBMw6xGwM4ldyVf5OoY4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848697; v=1; x=1793453497;
 b=HiL0z4X+vW6gZ5VhUCcm49WxIIW/pQGRYHIaI/RB3EpfwAzEgoc34V+s8vvoefh6lPEyhzXu
 msKOAWi135/oQPuZ6vyPv/1PZSwcAQuoJkUcTZq3Y8Agaace56d97QQHsK9jp3r4fKH+8RxxKd7
 2Yxe9iD6/J6JSOkGoBieuykE=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id d2bc4e68a3f66115;
	Sat, 24 Oct 2026 13:31:37 +0000
X-Mizu-Trace-ID: d2bc4e68a3f66115
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 11/15] net: optimize napi_threaded_poll() vs RPS/RFS
Date: Sat, 24 Oct 2026 21:30:35 +0800
Message-Id: <57e74f16f95713477009330d7cafa9519f188164.1792847032.git.wen.yang@linux.dev>
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

commit 87eff2ec57b6d68d294013d8dd21e839a1175e3a upstream.

We use napi_threaded_poll() in order to reduce our softirq dependency.

We can add a followup of 821eba962d95 ("net: optimize napi_schedule_rps()")
to further remove the need of firing NET_RX_SOFTIRQ whenever
RPS/RFS are used.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/linux/netdevice.h |  3 +++
 net/core/dev.c            | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 987177cebe7c..b399773d123b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3161,7 +3161,10 @@ struct softnet_data {
 #ifdef CONFIG_RPS
 	struct softnet_data	*rps_ipi_list;
 #endif
+
 	bool			in_net_rx_action;
+	bool			in_napi_threaded_poll;
+
 #ifdef CONFIG_NET_FLOW_LIMIT
 	struct sd_flow_limit __rcu *flow_limit;
 #endif
diff --git a/net/core/dev.c b/net/core/dev.c
index cac16e17ccf9..ab012a7eee94 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4744,10 +4744,10 @@ static void napi_schedule_rps(struct softnet_data *sd)
 		sd->rps_ipi_next = mysd->rps_ipi_list;
 		mysd->rps_ipi_list = sd;
 
-		/* If not called from net_rx_action()
+		/* If not called from net_rx_action() or napi_threaded_poll()
 		 * we have to raise NET_RX_SOFTIRQ.
 		 */
-		if (!mysd->in_net_rx_action)
+		if (!mysd->in_net_rx_action && !mysd->in_napi_threaded_poll)
 			__raise_softirq_irqoff(NET_RX_SOFTIRQ);
 		return;
 	}
@@ -6777,11 +6777,19 @@ static int napi_threaded_poll(void *data)
 
 			local_bh_disable();
 			sd = this_cpu_ptr(&softnet_data);
+			sd->in_napi_threaded_poll = true;
 
 			have = netpoll_poll_lock(napi);
 			__napi_poll(napi, &repoll);
 			netpoll_poll_unlock(have);
 
+			sd->in_napi_threaded_poll = false;
+			barrier();
+
+			if (sd_has_rps_ipi_waiting(sd)) {
+				local_irq_disable();
+				net_rps_action_and_irq_enable(sd);
+			}
 			skb_defer_free_flush(sd);
 			local_bh_enable();
 
-- 
2.25.1

