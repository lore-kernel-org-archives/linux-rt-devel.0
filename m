Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74130C610
	for <linux-rt-devel@lists.linux.dev>; Wed,  6 May 2026 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052370; cv=none; b=TkWk94exGoFyJ92IB5TsC7zekiTxw6oTWBMQ9ihkFjuBjaov/STi8K0IheeZQmSXxvtjAq00Uy/cNEtcwsnTc/8vhmSBldHXS6yThqtjkjEaJCV0DDzk40Q3IcF7MxDqF1gDtz5LhbMSdshx8wWVegJfhVN6nrBC3UKw+8R2+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052370; c=relaxed/simple;
	bh=FUgqcwlqHZvuXQFkTp2cH0PZJLSFbwKOjopx/wLUl0s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dr8HPJ0Patt5Q2+mYYce1vBP3aXUB/lcnr3Iv9DuUHSwx1W2X8Ac7dy3Ev5rl6C5ixcj8UXTMNicc0qlAP84qPi7MCTRMSuYRBsTSYPHhl60aNL6Rpj2Hgk07SuX6s+orCGEx/SU1I9tVeQGCVX2iiyIp7imXlyKg2Mi75J5ivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LiCVY/yE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LiCVY/yE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778052369; x=1809588369;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=FUgqcwlqHZvuXQFkTp2cH0PZJLSFbwKOjopx/wLUl0s=;
  b=LiCVY/yEz5UogSg6oR3mknMHbfh0y+VfEpwDJhO0Cdw4ydfsQTfCXuBE
   6ICQF/86Yq/mEMTzELNdpp5/clzv/qILoGzzY3vd4iBBhB+L0wHDdp4Mg
   j10/dz5GSkKv9CkH9Jv0Srb4aT/oTMorYuFqHBusO5qrQTo3jjEFN6P00
   ciyn9BuQSGYlmssP1pHH2ifpkqRzancStT0lQf4YDFhV/bRAtz14EnhRr
   ZtHqXBTXzJ6vRbugOfPMwZSroN03gZIfnniagCejs5Q0vCe0Nz9qKCdLH
   hlCUfCXuCcIPijaxUkx7car/w36E40OeWuTpz7H7yNLFS7s9jxy+eU7TL
   A==;
X-CSE-ConnectionGUID: mdJjxWYtRtGSZSmgn51qzA==
X-CSE-MsgGUID: wDek4DCXQ9qsBUc39xrVEQ==
X-IronPort-AV: E=Sophos;i="6.23,219,1770620400"; 
   d="scan'208";a="57515437"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:26:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Wed, 6 May 2026 00:26:08 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 6 May 2026 00:26:04 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net v2 0/4] net: sparx5: misc fixes for sparx5 and lan969x
Date: Wed, 6 May 2026 09:25:35 +0200
Message-ID: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/s+mkC/31OSw6DIBC9ipl1p0EUrF31Ho0LpFgnqUAYY2yMd
 y/hAF2+/zuAXSLHcK8OSG4jpuAzkJcK7Gz82yG9MgYppBatvOFCbHGi3TFyNGlX+DG+1/2Oo5W
 9ro3qxDRCzsfkii/Hn+DdCkMmZ+I1pG/Z2+oilWol2j/VW40CdT7QCD2qrm0eC9kU7EzxasMCw
 3meP+2h4lPLAAAA
X-Change-ID: 20260428-misc-fixes-sparx5-lan969x-bc2961a570fb
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
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>, Andrew Lunn
	<andrew@lunn.ch>
X-Mailer: b4 0.14.3

This series fixes various issues in the sparx5 driver, which also
serves lan969x.

Details are in the individual commit descriptions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Rework patch #2 to use ndo_set_rx_mode_async (Jakub)
- Link to v1: https://lore.kernel.org/r/20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com

---
Daniel Machon (4):
      net: sparx5: defer VCAP debugfs creation until after netdev registration
      net: sparx5: fix sleep in atomic context in MAC table access
      net: sparx5: fix wrong chip ids for TSN SKUs
      net: sparx5: configure serdes for 1000BASE-X in sparx5_port_init()

 drivers/net/ethernet/microchip/sparx5/Makefile     |  3 ++-
 .../net/ethernet/microchip/sparx5/sparx5_debugfs.c | 26 ++++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  4 ++--
 .../net/ethernet/microchip/sparx5/sparx5_main.h    | 17 +++++++++-----
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |  8 ++++---
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  3 ++-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |  6 -----
 7 files changed, 49 insertions(+), 18 deletions(-)
---
base-commit: 98878ed91b68a3150126fccef125ee7b1bb86ab2
change-id: 20260428-misc-fixes-sparx5-lan969x-bc2961a570fb

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

