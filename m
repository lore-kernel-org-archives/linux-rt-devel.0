Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174B4418CB
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981333; cv=none; b=SMBS3sBDEf+zphaTmdhA4RTMQs9KQ6+XsszFcwr5nIRvujiurYBheNI3cARNxFOMwprdxCiqPuIo3Zg/Lezb8gxUHzzMjfPrEOcirIJOeX6w0Hu5PrdTUO7GZ1UpNWjpcFgpPm8RnZ41jrQtsypi9xt8Fxotk4Zr1RUcFTyH4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981333; c=relaxed/simple;
	bh=aft+SGCCWz/ySdM2f/xLt6qBj8ixlAwYEDkY4Fj7DCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D1CEL+qmisZpqIMu1zpMDtelnYq+gKR9iuwlPqtRtuCB68C1ftt8ULoIArd4JjrsbTOQUHIHk9+kjhpHMwBrzn5EFZOMY+5KF5ng1uYCmlrJCyt5hdG0x8InioNaxPoYiEdqSXvEs7M2PcZY8URsCxctcEhvER5GoQtEoU7aEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rWdYTlp7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rWdYTlp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786981332; x=1818517332;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aft+SGCCWz/ySdM2f/xLt6qBj8ixlAwYEDkY4Fj7DCM=;
  b=rWdYTlp7kxVLJj/LmbP+27+wOeuTCv21hWWiPoQ81n15jaKknnMCpaho
   b7kggqEUpkvVE0KjbaPkP9/1wXctLmn2yV/c6jUl6y11zZfnu2LL0ob/B
   xbH+PaJ4ZWXe2y8loEz685pYmRriViL+YMIuaKu2AqndSuwt+gvldoPpM
   uMxFchHXlq3SmCr7Q02PAfbPdfoGwvzGcQfK27NoeZFzo68iaFApte04R
   R94JXf66DZ5MfKnq7S1zIo+nfJNBIhK0IbbMGoSJuMSN8oOj5f31j1WeG
   3TsQ25XIFlgCa5rVHtfRwZ8ghBPPSrgs56cdMunPfBAvNUJwEC7QBoZSD
   Q==;
X-CSE-ConnectionGUID: LadDgCKrQOKBp/4es5iCwg==
X-CSE-MsgGUID: 7fvZZbFwR5yMZZb91e5UCg==
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="293621266"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2026 08:42:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 17 Aug 2026 08:42:10 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Aug 2026 08:42:06 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 17 Aug 2026 17:41:58 +0200
Subject: [PATCH net v3 1/2] net: microchip: vcap: use port number instead
 of netdev name for debugfs
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-misc-fixes-sparx5-lan969x-v3-1-c7c7fef723a8@microchip.com>
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

sparx5_vcap_init() runs before sparx5_register_netdevs() in probe, and
its debugfs setup calls vcap_port_debugfs() for every port using
netdev_name(ndev) as the debugfs file name. At that point the netdevs
have only been allocated, not registered, so dev->name still holds the
"eth%d" template and netdev_name() returns "(unnamed net_device)".
Every port tries to create the same file under vcaps/, producing a
flood of warnings at boot:

  debugfs: '(unnamed net_device)' already exists in 'vcaps'
  debugfs: '(unnamed net_device)' already exists in 'vcaps'
  ...

Add vcap_port_debugfs_portno(), a variant of vcap_port_debugfs() that
takes the port's stable hardware port number and uses "p%u" as the
debugfs file name instead of netdev_name(ndev). This makes the file
name independent of registration order; the file still stores and
later dereferences the netdev itself, same as before. sparx5 already
reports the same "p%d" string via ndo_get_phys_port_name(), so the
debugfs name now matches that.

Only sparx5 (and lan969x, which shares this code) is switched to the
new function. lan966x keeps calling vcap_port_debugfs() unchanged, so
this fix does not rename any of its existing debugfs files.

Fixes: b8909aad5b8d ("net: sparx5: move netdev and notifier block registration to probe")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c    |  5 +++--
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c  | 21 +++++++++++++++++++++
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.h  | 14 ++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index cf332de6bf73..2dee2ce19fce 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -2077,8 +2077,9 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 	dir = vcap_debugfs(sparx5->dev, sparx5->debugfs_root, ctrl);
 	for (idx = 0; idx < consts->n_ports; ++idx)
 		if (sparx5->ports[idx])
-			vcap_port_debugfs(sparx5->dev, dir, ctrl,
-					  sparx5->ports[idx]->ndev);
+			vcap_port_debugfs_portno(sparx5->dev, dir, ctrl,
+						 sparx5->ports[idx]->ndev,
+						 sparx5->ports[idx]->portno);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
index e0c65c7ab23e..476f7496a9d4 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
@@ -400,6 +400,27 @@ void vcap_port_debugfs(struct device *dev, struct dentry *parent,
 }
 EXPORT_SYMBOL_GPL(vcap_port_debugfs);
 
+void vcap_port_debugfs_portno(struct device *dev,
+			      struct dentry *parent,
+			      struct vcap_control *vctrl,
+			      struct net_device *ndev,
+			      unsigned int portno)
+{
+	struct vcap_port_debugfs_info *info;
+	char name[16];
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return;
+
+	info->vctrl = vctrl;
+	info->ndev = ndev;
+
+	snprintf(name, sizeof(name), "p%u", portno);
+	debugfs_create_file(name, 0444, parent, info, &vcap_port_debugfs_fops);
+}
+EXPORT_SYMBOL_GPL(vcap_port_debugfs_portno);
+
 /* Show the full VCAP instance data (rules with all fields) */
 static int vcap_debugfs_show(struct seq_file *m, void *unused)
 {
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h
index 9f2c59b5f6f5..7dc6e3411a4d 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.h
@@ -18,6 +18,12 @@ void vcap_port_debugfs(struct device *dev, struct dentry *parent,
 		       struct vcap_control *vctrl,
 		       struct net_device *ndev);
 
+void vcap_port_debugfs_portno(struct device *dev,
+			      struct dentry *parent,
+			      struct vcap_control *vctrl,
+			      struct net_device *ndev,
+			      unsigned int portno);
+
 /* Create a debugFS entry for a vcap instance */
 struct dentry *vcap_debugfs(struct device *dev, struct dentry *parent,
 			    struct vcap_control *vctrl);
@@ -30,6 +36,14 @@ static inline void vcap_port_debugfs(struct device *dev, struct dentry *parent,
 {
 }
 
+static inline void vcap_port_debugfs_portno(struct device *dev,
+					    struct dentry *parent,
+					    struct vcap_control *vctrl,
+					    struct net_device *ndev,
+					    unsigned int portno)
+{
+}
+
 static inline struct dentry *vcap_debugfs(struct device *dev,
 					  struct dentry *parent,
 					  struct vcap_control *vctrl)

-- 
2.34.1

