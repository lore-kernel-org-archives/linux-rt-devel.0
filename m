Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01E43F8C9
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981329; cv=none; b=HKh4UTaG2rgiF+ozYlugRImSDlb5epCNY/E18Yzy9BF4kAJW8OEvDHPcspkOJ9VmtbGkMKosaE9yojVbhbwGxEQTCGwjy5u8/3PWLPviNOMuVxmmRQvd+PzZvf2+W9kgF/zfGvVpomRnRsS2ODRaxefqX8PHB+NDihqNjwQgigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981329; c=relaxed/simple;
	bh=Jtg5vk7ejVdQ82vIV6q0t9vsQQoXsAf++NSCdTq+K94=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=u7h6L2WnfwlSo69jpQKz9j/1UdPZ1IE1xNE82eRygvDbE2qMwgiVquLLQKm7QbDKhOZ9tD6Ie8KMWLgyGp5RYOitpXHYpuANHB7ezMIDlvZURSJefEz8ghtjgU6TDcntXpTOLMjfUT3GFMmRvz6tvNOAe/h6I2eVnMn//+hX3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RqJ6Jl8X; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RqJ6Jl8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786981331; x=1818517331;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Jtg5vk7ejVdQ82vIV6q0t9vsQQoXsAf++NSCdTq+K94=;
  b=RqJ6Jl8X3ape1AQWcwJScJrwiSuJblBR6x043AntcT6EVEjogGZnCNV6
   ifhtME0ik8VCQAz5L7NOMLwNeu6HBzBZLQZ7/9tdJw7vMXFLmMs4IYELT
   W0/GTrAG7tcnAzW4qcMsDmqulWBxVaa0OggrnOsDVjyyWU77s5MY3t2SW
   jijXnJljdhXB5tywXMKzo0C0dSwmuwacJBYkHOdiUPKFvA3HM2AR+/lXp
   QeSUEVql+8a11LalZf2+FHaQx6moNQ5S1yG6K9Ive1u0CY0/tMtdOiOeT
   9UntPzHF3qwnXcGQ67RgYpc0ASCsNy6HxVt2mbW/kHFPHN5Pm4DjLMpUI
   Q==;
X-CSE-ConnectionGUID: UMlPrz88T3myxF5gMCCkYg==
X-CSE-MsgGUID: EyJrNUZUSUWXyT0Xk0oBKA==
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="62559689"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2026 08:42:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 17 Aug 2026 08:42:06 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Aug 2026 08:42:03 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net v3 0/2] net: sparx5: misc fixes for sparx5 and lan969x
Date: Mon, 17 Aug 2026 17:41:57 +0200
Message-ID: <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUrg2oC/33OSw6DIBAG4Ks0rDsNgqB21Xs0XQDFOkkVA4bYG
 O/eCaumC5fz+L+ZjSUf0Sd2PW0s+owJw0SFPJ+YG8z08oBPqpngQvNatDBictDj6hOk2cRVwdt
 Mne5WsE50ujKq4b1llJ+jL3sUv7PJL+xBzQHTEuKn3MtVGRVa8fqAzhVw0PSA5Nqqppa3EV0Mb
 sD54sJY5Cx+NX2kCdJ6K6Q2hhq8/df2ff8CC16qQBkBAAA=
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
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>
X-Mailer: b4 0.14.3

This series fixes various issues in the sparx5 driver, which also
serves lan969x.

Details are in the individual commit descriptions.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v3:
- Patch #1: retitled to net: microchip: vcap:, since the fix lives in
  the shared VCAP debugfs helper; name the VCAP debugfs entry after
  the stable port index instead of the netdev name, which can change
  at runtime (Jakub). Added as a new vcap_port_debugfs_portno()
  helper, so lan966x's existing per-port debugfs files are untouched.
- Patch #2: update sparx5_set_rx_mode() to return int, matching
  .ndo_set_rx_mode_async's return type, and propagate
  __hw_addr_sync_dev()'s return value instead of always returning 0
- Drop patches #3 and #4, already merged upstream
- Link to v2: https://lore.kernel.org/r/20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com

Changes in v2:
- Rework patch #2 to use ndo_set_rx_mode_async (Jakub)
- Link to v1: https://lore.kernel.org/r/20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com

---
Daniel Machon (2):
      net: microchip: vcap: use port number instead of netdev name for debugfs
      net: sparx5: fix sleep in atomic context in MAC table access

 .../net/ethernet/microchip/sparx5/sparx5_netdev.c   | 11 ++++++++---
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c    |  5 +++--
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c  | 21 +++++++++++++++++++++
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.h  | 14 ++++++++++++++
 4 files changed, 46 insertions(+), 5 deletions(-)
---
base-commit: e6a5d573d24cd375e09d24f136523cb3cc85c9d3
change-id: 20260428-misc-fixes-sparx5-lan969x-bc2961a570fb

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

