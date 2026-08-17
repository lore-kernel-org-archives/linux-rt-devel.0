Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E7447814
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981336; cv=none; b=D0U687nvomuu8WCFYHHkcsCCg79Uj2lKY+gDPOxbl4Zzsi5y6LdnTxB0VU2jXVsa1BAPJoHPseHkzxT3rWh81AlyxKG4o0Lk7W/09nPiQRKaEDQYpMW3e3kbfiPMQORmcn8iIA2Pk7w8D+o8NGEICUK0YPuOVCdfwmO4LdZEsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981336; c=relaxed/simple;
	bh=I+TvvVFLIG/W6yKgqSqTKmbGohoiQBrZlp+7d28waKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fYIVBAuQB31y5R5h+84F0XN0v5Pdx2OIjyE5CAo6R1mBiuC4SES7VeYgxL7I4MaeDlx7Z1mQ73r3WV4x7GHzUyHNOrFmPCnGPI/7iBPVkehMH2lHEmnCIH3v2ZhVzm1OMJSkyTXNi+giBWrHqjyF/MpE2x77QGRm7jaBjso2ZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a0uvYX3e; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a0uvYX3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786981335; x=1818517335;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=I+TvvVFLIG/W6yKgqSqTKmbGohoiQBrZlp+7d28waKc=;
  b=a0uvYX3eWoWVvgpFE4kpy0a3HsMB46z92fkKqtAK8pvAg51qnEeTOGzO
   sGV8ILkn3Wjq97OJPITFS4VwqwpgA/qXmXJsDxjh4YKw4+mlQhstIT/sN
   ucjEV1L+ScJX4joqbM+e9sXFt8lZ9DMso7XCSgocvOdkMNq5e+EujuUhM
   tjXf+pab6Ag15SHI93THGwFWxhqCtTnq8NaWKgEusuV7A0QagCFBHoFvw
   Fk3fTAwhM+LWcA+YE6zyQuu61juCh5sYBUBBoh2rmBx+TRiY8jds4goMW
   M1vT0qDcGqp1CVywtieyqr9Qa5zGcsLxO8HmDajr/Yj6vYRq0UXdBNbkX
   g==;
X-CSE-ConnectionGUID: LDPybZDUTGmfHmOqR+FUrA==
X-CSE-MsgGUID: MK1CRNfGRvec81PnvLQkDw==
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="293621269"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:42:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 17 Aug 2026 08:42:13 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Aug 2026 08:42:10 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 17 Aug 2026 17:41:59 +0200
Subject: [PATCH net v3 2/2] net: sparx5: fix sleep in atomic context in MAC
 table access
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-misc-fixes-sparx5-lan969x-v3-2-c7c7fef723a8@microchip.com>
References: <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
In-Reply-To: <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>
X-Mailer: b4 0.14.3

sparx5_set_rx_mode() runs with netif_addr_lock_bh held and iterates
dev->mc via __dev_mc_sync(), which per address calls sparx5_mc_sync() /
sparx5_mc_unsync() -> sparx5_mact_learn() / sparx5_mact_forget().  These
take sparx5->lock, a mutex, and then poll the MAC access command
register with readx_poll_timeout(). A mutex may block, which is not
allowed from atomic context.

Convert the driver to the new .ndo_set_rx_mode_async callback introduced
in commit 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and
netdev_rx_mode_work"). The async callback is invoked from process
context, so the mutex and sleeping completion poll can remain.

Observed with CONFIG_PROVE_LOCKING, CONFIG_DEBUG_SPINLOCK,
CONFIG_DEBUG_MUTEXES and CONFIG_DEBUG_ATOMIC_SLEEP enabled:

  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 217, name: ip
  preempt_count: 201, expected: 0
  Call trace:
   __might_resched+0x144/0x248
   __might_sleep+0x48/0x7c
   __mutex_lock+0x74/0x850
   mutex_lock_nested+0x24/0x30
   sparx5_mact_learn+0x78/0x100
   sparx5_mc_sync+0x40/0x54
   __hw_addr_sync_dev+0xc4/0x170
   sparx5_set_rx_mode+0x4c/0x58
   __dev_set_rx_mode+0x64/0xa4
   __dev_open+0x1ec/0x26c

Fixes: d6fce5141929 ("net: sparx5: add switching support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 1d34af78166a..4dedf5d92641 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -162,13 +162,18 @@ static int sparx5_port_stop(struct net_device *ndev)
 	return 0;
 }
 
-static void sparx5_set_rx_mode(struct net_device *dev)
+static int sparx5_set_rx_mode(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct sparx5_port *port = netdev_priv(dev);
 	struct sparx5 *sparx5 = port->sparx5;
 
 	if (!test_bit(port->portno, sparx5->bridge_mask))
-		__dev_mc_sync(dev, sparx5_mc_sync, sparx5_mc_unsync);
+		return __hw_addr_sync_dev(mc, dev, sparx5_mc_sync,
+					  sparx5_mc_unsync);
+
+	return 0;
 }
 
 static int sparx5_port_get_phys_port_name(struct net_device *dev,
@@ -249,7 +254,7 @@ static const struct net_device_ops sparx5_port_netdev_ops = {
 	.ndo_open               = sparx5_port_open,
 	.ndo_stop               = sparx5_port_stop,
 	.ndo_start_xmit         = sparx5_port_xmit_impl,
-	.ndo_set_rx_mode        = sparx5_set_rx_mode,
+	.ndo_set_rx_mode_async  = sparx5_set_rx_mode,
 	.ndo_get_phys_port_name = sparx5_port_get_phys_port_name,
 	.ndo_set_mac_address    = sparx5_set_mac_address,
 	.ndo_validate_addr      = eth_validate_addr,

-- 
2.34.1

