Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848674;
	b=nrvXSZQyNWKL9hBS6UbYtVukA3+RQ9XqiVALUuJTCiTI3b2b9cw5cyI/KjeHyx7YMyf4
	 T5gpkWWMB0x2mdYq3EU582sxSEDNG7aIMJm1YObv3uePhRo68TknfZ1k2Vux0oyEMP/LP
	 se4Roz9rA/4gDXF6CXjitEyQnw1sBfYF3W3C2t9NfpOpZ3uE8BVANQtF1bGFMgG4pVOne
	 SgVwgS5ZixTaOwznI9tc5qM2Y4ReBeRGWlHDNrGdpnO5/rm5r5xUFuVv9/yf+osBBxNU+
	 RiKJKYNoPpDJqfANFOUK4t+CqYj6maoD9qyTCjl+EtJX2kxkNpICD4Gj2xuv7CWl8HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848674;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rj8JMh1DvwfoIS7eicQbSTeOl+YNNlg53ZQUOOKsiQA=;
	b=hvOs81pWMOCXuDiStzwwj24ZLZTWUhXk5i9jRqedNMl74AhcVBhle7L2blvdFWyC3Arr
	 vcf4vG6DKSB7giJMME5c+uUY/vRDjYmM5jQCUTkpR1A2jl+LS1ileAXI+4nh3ntxk09da
	 lLhnthwVq5zVJphoUN32VHfN29rZnyOZtv2Lp78KYPQgH+dQgTTqu8taiJsPnLL5Ontyb
	 ScHeG7dYHv2uVb83p5Z5AH8eCdSU8G0kREfKT29wMhHtLkjpEueUI2M2jIQ5qbMR/F5Pr
	 bAAHsnbNuK0vhLAJRZQnCKdI5aqRZUq4yXr6/5rkttS+uynIMga2e0QfS9o7gpdvMEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QnYK6pHg;
	arc=none smtp.remote-ip=95.215.58.33
Received: from mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E6606A31E
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F37E6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QnYK6pHg
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ZDaRAOGl+KPtg280C/lWnY6cxSz/5bl3EgoRIDVkrWw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848671; v=1; x=1793453471;
 b=QnYK6pHgCeUAvGLOwfdZBskROfQyEYSPAWMCeIfzkdtTmzVlkqPFEpX38Oigg8FH/8+at9Pv
 nd+F4/LXn66UKUTA/6XVttl0CSrNXua52Y2XqzTW1QNUYncy9v4QR3jkvUWLgfKvmXsEckHfvtp
 EMWnXSXi/7tikog/ftiGjydo=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id a807c40e9c277f20;
	Sat, 24 Oct 2026 13:31:09 +0000
X-Mizu-Trace-ID: a807c40e9c277f20
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 06/15] net: optimize ____napi_schedule() to avoid extra NET_RX_SOFTIRQ
Date: Sat, 24 Oct 2026 21:30:30 +0800
Message-Id: <28180b4d8b87f68a7e5af04603448a5448239d6e.1792847032.git.wen.yang@linux.dev>
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

commit 8b43fd3d1d7d88293eb15e92090826e6b7cc13e4 upstream.

____napi_schedule() adds a napi into current cpu softnet_data poll_list,
then raises NET_RX_SOFTIRQ to make sure net_rx_action() will process it.

Idea of this patch is to not raise NET_RX_SOFTIRQ when being called indirectly
from net_rx_action(), because we can process poll_list from this point,
without going to full softirq loop.

This needs a change in net_rx_action() to make sure we restart
its main loop if sd->poll_list was updated without NET_RX_SOFTIRQ
being raised.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 10a8883ae490..db1fe85ebc90 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4498,7 +4498,11 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	}
 
 	list_add_tail(&napi->poll_list, &sd->poll_list);
-	raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	/* If not called from net_rx_action()
+	 * we have to raise NET_RX_SOFTIRQ.
+	 */
+	if (!sd->in_net_rx_action)
+		raise_softirq_irqoff(NET_RX_SOFTIRQ);
 }
 
 #ifdef CONFIG_RPS
@@ -6797,6 +6801,7 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
+start:
 	sd->in_net_rx_action = true;
 	local_irq_disable();
 	list_splice_init(&sd->poll_list, &list);
@@ -6808,9 +6813,18 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 		skb_defer_free_flush(sd);
 
 		if (list_empty(&list)) {
-			sd->in_net_rx_action = false;
-			if (!sd_has_rps_ipi_waiting(sd) && list_empty(&repoll))
-				goto end;
+			if (list_empty(&repoll)) {
+				sd->in_net_rx_action = false;
+				barrier();
+				/* We need to check if ____napi_schedule()
+				 * had refilled poll_list while
+				 * sd->in_net_rx_action was true.
+				 */
+				if (!list_empty(&sd->poll_list))
+					goto start;
+				if (!sd_has_rps_ipi_waiting(sd))
+					goto end;
+			}
 			break;
 		}
 
-- 
2.25.1

