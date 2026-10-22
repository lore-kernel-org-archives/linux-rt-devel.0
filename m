Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661955;
	b=HAj4ZSBvjx2PZsQbul6FQ4hMp/USnLDasYn9LuRANYrINwYKdVu6zo+VtopOLyYUqFW1
	 I/kP7xW+N0GyqJQe/UNkWpSYUopFHHB+G4uhiIUhcqpIx/CiOgiFcR7fci/V6Erypg1CC
	 qYR9ot25OeFP4FyuNo9HMsjPPXC/PmisUzgmqL3N0y5AzFQHW2YgSa+TlzwY/yS2uMcYe
	 Hr2TcUO/hi5V5UGzjZLVysms5W3E2BspYT+kJD9BctUAWT96ijHaPOpmK2L5AZHEq3eEX
	 BoiyApYKSmiuA1foRVeo+dFOnKaezJ6yREpxvO/eLJ9CsJJmErQQ3FiCKwSCB0cWSjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661955;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=XxXdmGBefXIrzD/kysy2SoJnuiPsXZhcIjTx70PQl4Y=;
	b=Yzu/0KBDj66RQ63z8Fqv4HBXOIQdofVzaJNP+vQQVYtIiej2fXmTnh7RVNVsTipYSDjz
	 bjgGxXum0RjpeukgzGAklyXGfDHkTmrIFjTnLPVLvCuUHmokU5NqF+jrgh+PdE9SXpNqf
	 vNKsTJS7XHfnSylC3SNZ41zTcGsWoYkrf9QeVPgqcjOYOKEgfi7vA8Co0wY5mLGU3J+CH
	 sCPj0wI6Sj0s9yPGIfGcB75hNqo6j11ampAMfP4tM2BcxaDIh6ePgXLrooccMA0kR0HSR
	 PVcKGP3JgYUR/5NMJOeICtdpAgO7dwpKpjFxzO2eE04sphij+GgNRWPZnbpP4HuR+5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=steffen.cc;
	spf=pass smtp.mailfrom=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b="DEXq+/fQ";
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AF60A3814
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 09:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 932AF60A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=DEXq+/fQ
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j9LhH5kZfzKmwp;
	Thu, 22 Oct 2026 11:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1792661951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxXdmGBefXIrzD/kysy2SoJnuiPsXZhcIjTx70PQl4Y=;
	b=DEXq+/fQs4o1+qcRXtlKo8sddKdqzjwtBIO0dzN9hz4UTExVaoTPRl2yzW/eSeINDHj1xq
	ltfTzYe/O3yWYWs/K4zDVuf7SodzO0bjwoDr3FuSM4w6yuxZbU6IwyF73FLGCI1BEDxUEn
	B+BdhIBTYrbDOYyDMF87e5VgyJOwhvL09hDxawvNgLxct+c01JTyLe9zneYEkztUQnMvY0
	cbYELxd8de/k813No7ROYhThPlOTsDfwqe41Vv1aqlIbQXM3PPhbUYQ5eXhGxyROkeWx9W
	edNW34GPoeP8nZIuiKT4Nmo6EpINlIYFVrGGjHIksxSrf+HSYw/cL2TjPHZ3lg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Thu, 22 Oct 2026 11:38:51 +0200
Subject: [PATCH RFC net 6/6] net: macb: keep best-effort traffic on TX
 queue 0
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-std-macb-v14-send-v1-6-9187bc545bf6@beckhoff.com>
References: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
In-Reply-To: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kevin Hao <haokexin@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661936; l=1891;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=5SFNsZwxQop4FNjc7v2pflVp7X+DnG6j0I1lOk/2tmQ=;
 b=IwcrrE5cSvhDpnKnBcgWX6a1x1V38/zPgm9mE8LqCvq1Tf1tY04eQyepELILKMSAg25W/poNT
 /sUEBsHUHezCdgf9ysOQkXKwHSCONZG+A00br5wbytuExix/hmyarJm
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4j9LhH5kZfzKmwp

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Add an ndo_select_queue() that puts every frame on queue 0 unless
traffic classes are configured (taprio, or software mqprio).

The GEM serves its transmit queues in strict priority order, the
highest queue first, while the stack hashes flows over all of them. On
a saturated link the flows on the lower queues starve until the netdev
watchdog fires on them, and the timeout path cannot help as nothing is
wrong with the queue.

XPS settings, the socket queue cache and the queue choice of
PACKET_QDISC_BYPASS sockets no longer take effect on multi-queue GEMs
without traffic classes; queues 1 and up stay reachable through tc.

Fixes: 02c958dd3446 ("net/macb: add TX multiqueue support for gem")
Assisted-by: LLM
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3dfc7ffdd598..eae43490c5f7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4596,10 +4596,21 @@ static void macb_tx_timeout(struct net_device *netdev, unsigned int q)
 	macb_tx_restart(&bp->queues[q]);
 }
 
+/* GEM serves TX queues in strict priority order, the highest queue first */
+static u16 macb_select_queue(struct net_device *netdev, struct sk_buff *skb,
+			     struct net_device *sb_dev)
+{
+	if (netdev_get_num_tc(netdev))
+		return netdev_pick_tx(netdev, skb, sb_dev);
+
+	return 0;
+}
+
 static const struct net_device_ops macb_netdev_ops = {
 	.ndo_open		= macb_open,
 	.ndo_stop		= macb_close,
 	.ndo_start_xmit		= macb_start_xmit,
+	.ndo_select_queue	= macb_select_queue,
 	.ndo_set_rx_mode	= macb_set_rx_mode,
 	.ndo_get_stats64	= macb_get_stats,
 	.ndo_eth_ioctl		= macb_ioctl,

-- 
2.56.0

