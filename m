Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D564034A788
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Apr 2026 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775706858; cv=none; b=N/MoCcmOOggASvyVF827NbMjpPQ+1I2QZAOIee2/bhmyTnYmC1V0p93JqKwEtYhYDAbNymKsq+oBl9O1qIlqZfBtTC5cRDVfE2KLMLLPhi3Olva3tb1G+nKMaTKowsGbBWlmKIg4SSpw5LKDXfxjLfE9ciMK7oxeaD+BHxx8bqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775706858; c=relaxed/simple;
	bh=Jbs4PD9pBuyZ/k04H6gAL9IMQftAAPsydvMFDezt3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4F0JR3uUuldB4t74b1tzp2rsi4wD71P9mPmJ5baQer3MDQ0JDzVTfYksY/a/AcXnh4zdfwKe3tx4lLZ6lGb4vOketiqJZ8F70QZbNAlbUCuc8hJF+VfJkIzngzSWxBoTZM1p4Jiuf/UNUHBqFNGvw0FvUPAmUtg1KtoMzvPvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mhyKhlJG; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mhyKhlJG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775706853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f+uIdvNv559zfYY9XiHAQzaBvGDZyQXDoiCkabS6QEI=;
	b=mhyKhlJGsH9UhWxddZPQmF7Gsmp5xr+CIoGiOoUc2pdtC49dQpDURAFzOgHL6WNSmJGy3b
	0M1wv8HFk5HN5gr54Qnn4dOcWuJFbxmYDD3eN4Itc7NCUA/V7LOkhsIgxoXUfiHLYK7GH3
	Ue6N+PSgdFZLram9xRv21ltlZqvDHTg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net] net: fix __this_cpu_add() in preemptible code in dev_xmit_recursion_inc/dec
Date: Thu,  9 Apr 2026 11:53:43 +0800
Message-ID: <20260409035344.214279-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

dev_xmit_recursion_inc/dec() use __this_cpu_inc/dec() which requires
migration to be disabled. However, some callers like SCTP's UDP
encapsulation path invoke iptunnel_xmit() from process context without
disabling BH or preemption:

  sctp_inet_connect -> __sctp_connect -> sctp_do_sm ->
  sctp_outq_flush -> sctp_packet_transmit -> sctp_v4_xmit ->
  udp_tunnel_xmit_skb -> iptunnel_xmit -> dev_xmit_recursion_inc

This triggers the following warning on PREEMPT(full) kernels:

  BUG: using __this_cpu_add() in preemptible [00000000]
  caller is dev_xmit_recursion_inc include/linux/netdevice.h:3595 [inline]
  caller is iptunnel_xmit+0x1cd/0xb80 net/ipv4/ip_tunnel_core.c:72
  Tainted: [L]=SOFTLOCKUP
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94 [inline]
   dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
   check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
   dev_xmit_recursion_inc include/linux/netdevice.h:3595 [inline]
   iptunnel_xmit+0x1cd/0xb80 net/ipv4/ip_tunnel_core.c:72
   sctp_v4_xmit+0x75f/0x1060 net/sctp/protocol.c:1073
   sctp_packet_transmit+0x22ec/0x3060 net/sctp/output.c:653
   sctp_packet_singleton+0x19e/0x370 net/sctp/outqueue.c:783
   sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
   sctp_outq_flush+0x315/0x3350 net/sctp/outqueue.c:1212
   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1824 [inline]
   sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
   sctp_do_sm+0xce1/0x5be0 net/sctp/sm_sideeffect.c:1175
   sctp_primitive_ASSOCIATE+0x9c/0xd0 net/sctp/primitive.c:73
   __sctp_connect+0x9fc/0xc70 net/sctp/socket.c:1235
   sctp_connect net/sctp/socket.c:4818 [inline]
   sctp_inet_connect+0x15f/0x220 net/sctp/socket.c:4833
   __sys_connect_file+0x141/0x1a0 net/socket.c:2089
   __sys_connect+0x141/0x170 net/socket.c:2108
   __do_sys_connect net/socket.c:2114 [inline]
   __se_sys_connect net/socket.c:2111 [inline]
   __x64_sys_connect+0x72/0xb0 net/socket.c:2111
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fix this by adding migrate_disable/enable() around the __this_cpu
operations in dev_xmit_recursion_inc/dec() to ensure the per-cpu
variable is accessed on the same CPU throughout the inc/dec pair.

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/netdevice.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7ca01eb3f7d2..6b1cd5380d70 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3591,14 +3591,19 @@ static inline bool dev_xmit_recursion(void)
 			XMIT_RECURSION_LIMIT);
 }
 
+/* Non PREEMPT_RT version: inc and dec must run on the same CPU,
+ * migrate_disable is sufficient.
+ */
 static inline void dev_xmit_recursion_inc(void)
 {
+	migrate_disable();
 	__this_cpu_inc(softnet_data.xmit.recursion);
 }
 
 static inline void dev_xmit_recursion_dec(void)
 {
 	__this_cpu_dec(softnet_data.xmit.recursion);
+	migrate_enable();
 }
 #else
 static inline int dev_recursion_level(void)
-- 
2.43.0

