Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848670;
	b=CQ3HRcma0Kg4XeF159b1rl8uan+jBatvgEGfRpICznUFjF3r69Sheq+ZRbecrHRFyOJi
	 2fuvWKuejqUwggspMeBAsa6L9zx1/q6mzCyzAyEU09JExHsrbFQIADWbLaMiuXN/Jrdgp
	 eykoPB11qlGn0kTX8Oo0Fr3tKccUa4hQDX9V3hT6YO2b3la4fuQI6TKfOyzwZzIWDSbso
	 gxOVlgd6iXidZVOoNYRtabDruQ4QW8Bymg5Te+TreSyunzRnlZt3q4V8iJj4p+QtVTvmc
	 FFwM/845EED7ZN6zo6kqbcwMWLU+KKd75hsK2HiXv3J2Tn+sP/K7KpqIPFZx1tq1e0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848670;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qI5ufOR11k0J0izH9jtV5AJQA5+/6r9HFl/lo8vFB8U=;
	b=FG7lgSwtiPX6lthyE5ziEiYn/XWfdV8LZIQU/LZPdQepg4gtK1gph6m8THlJKZ/omWxi
	 Q4fcaZ1rC4cym0ANz0sFCaCwFnTfQxm+Toq7SXCbWo/afOyq8LAfRVH08DysixYI6+m5N
	 3X/f4scXOV8jkFqbB9YJ1Y6zW7c5DICRpBOLDZ9uBJY5OeL//VUmQ4wtb2NqG9/EIuT5/
	 gK1VVGz9VzB0Egtlr3dUkhMbvfTy1mj0jNBWSyVXu82J6PJmgZgDSOZAbGNmDt5QBloNi
	 BO3GNQaXHnFXE2pKYGmedMN5Qr9vHkAlS5H9HrCVt+WXotVfPigdBuZPu5sSeUsTAoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WcFeAmlQ;
	arc=none smtp.remote-ip=91.218.175.38
Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB8606A31B
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FB8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WcFeAmlQ
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=KzjAP5mj+qZ64QCBziF9G7xxImjiEPrykcdJXSVUj50=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848666; v=1; x=1793453466;
 b=WcFeAmlQ+Tzg4oyFXxsJUQyt3zCkxXXLoRnIlOKwX2s24rPZAuQ0DNmRCx+FZutK06wUnggR
 iVCJjf2lWK3WZ0gf/1Sqhs58jIm74pYTBxGOnBcBYZ4l9gfXEYFE+eohVEIKciYix3o3uXaFcCH
 5d8zXf9YdMebx+c8vnpuwIS8=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id fbed8bc39a469ed5;
	Sat, 24 Oct 2026 13:31:06 +0000
X-Mizu-Trace-ID: fbed8bc39a469ed5
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 05/15] net: optimize napi_schedule_rps()
Date: Sat, 24 Oct 2026 21:30:29 +0800
Message-Id: <080f98e68c598f3c40188054537ff646478dfbed.1792847032.git.wen.yang@linux.dev>
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

commit 821eba962d95806beb0440742c4062a9da8a386b upstream.

Based on initial patch from Jason Xing.

Idea is to not raise NET_RX_SOFTIRQ from napi_schedule_rps()
when we queued a packet into another cpu backlog.

We can do this only in the context of us being called indirectly
from net_rx_action(), to have the guarantee our rps_ipi_list
will be processed before we exit from net_rx_action().

Link: https://lore.kernel.org/lkml/20230325152417.5403-1-kerneljasonxing@gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a46caebb06f7..10a8883ae490 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4727,8 +4727,6 @@ static void trigger_rx_softirq(void *data)
  *
  * - If this is another cpu queue, link it to our rps_ipi_list,
  *   and make sure we will process rps_ipi_list from net_rx_action().
- *   As we do not know yet if we are called from net_rx_action(),
- *   we have to raise NET_RX_SOFTIRQ. This might change in the future.
  *
  * - If this is our own queue, NAPI schedule our backlog.
  *   Note that this also raises NET_RX_SOFTIRQ.
@@ -4742,7 +4740,11 @@ static void napi_schedule_rps(struct softnet_data *sd)
 		sd->rps_ipi_next = mysd->rps_ipi_list;
 		mysd->rps_ipi_list = sd;
 
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		/* If not called from net_rx_action()
+		 * we have to raise NET_RX_SOFTIRQ.
+		 */
+		if (!mysd->in_net_rx_action)
+			__raise_softirq_irqoff(NET_RX_SOFTIRQ);
 		return;
 	}
 #endif /* CONFIG_RPS */
-- 
2.25.1

