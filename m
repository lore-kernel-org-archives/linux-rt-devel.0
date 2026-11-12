Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794538035;
	b=4u0HSpZqutRUr4xuwPqYhsoKgK42RCeBVK6lNUjOhIgePF+VhBRmAGOAL0QdF1Ziouxu
	 sHyi2ovUvXVCBUW8aZa/6pGqpeK8mByqvl/5+aPnMg+lv+QAVr/b5QNRPZjCrYmnwUF69
	 +bPdLYLg+nJcP/sZOTJq3JJ8x2jYUyE3iAJItDq6UxS0N8e1QPT/ngqU1FIxGnJ9PDuH5
	 SMqmEAdBW0k/f9EWBfXe+htx+5xesbVVa9O2C6Y/zf5jyqFv1uNOdXw9FlEf4lO58Hb9L
	 ohEZYlVMc+Z/xXxcde4bDSeimxWnC7uaBar+tun6bMqIweegFUMasNsmdwlfIl/Fx2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538035;
	h=DMARC-Filter:DKIM-Signature:X-MS-Exchange-Authentication-Results:
	 Received:Received:Received:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=P14KhoMXfGPni5qi61eVjUkVCq90IQqObPqvQa87lCY=;
	b=5elieADcY+CjQHX2hc75LdFYvFbhqAvMqyVCuh2K9pes33HXB3AJNgkzs21cV3GblBsN
	 X7OGneZJftUBE48UZxfNTHLKfyO2U5R5o0iu8ASqvYKrUTAkrNINdl/OTILprDWdclAMg
	 3wVleL+uHMuhZCDc1emVkla9Jkbm/Q0PKdQ+FrdH4Mx5LgiQoRsTdmluzgY+dPNLns+pz
	 5i97puIh414c7HWEY3EOkVLzbU8ycOBOV+7mAbNZF8s1y3ZUN2QNfgL18SY9AfKlpvJyX
	 8C5WMjKhkkOt1sO70mUUuj45PapSQu+d644/G1GAbiZWnzbBQmMkl6s9y2qtuOthJfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cimBUg+3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.7
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0917606A321
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 02:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0917606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cimBUg+3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMeQP/b+Diuo5Tw3nknM13XPP8n4C1NMGBn6z2rz00w7yCSGI9C4LhSoSOPXhu6yEejX0P3ax4Z0tuvyJ9V1rco3Q9zQLckfg15rrHp10fi/lWyFRotrjteTYomG47OHwQAhckUEUCKCVTEJaCb4ENRR2f7edgeBoQXsOe2w5th1rgBgCLz4zMWbf0cKk/qw8jRB5DyTz7jk3NtWrL+GxZG4l6UutoEZytiWhMZBONQQBaJsdHAPx6oorCevV6h3hrZP+AHoFPrwNmOZWubZPQYCaJUJSKlMpI7ZXkRoS1CFI2TnyPtNb8CW3vltDBdYelvgBo5F7OxNWvos8CaIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P14KhoMXfGPni5qi61eVjUkVCq90IQqObPqvQa87lCY=;
 b=PTkDaHochbbbT4pHbGjzE3XxhnCu4qHhejzj2ZfxbjLT0AINPqj6VgMF6U3bgz/khhVtAfwCtuN8n5LzYZ1G44UwVEN7G51ZQjySYUCuqwbJlVPV+D0YtgLEq+BSSadyiZBWXWNXOLMGgK7wPNwMN252oggRkSb7m7DmNdJERJdMnpOeME5MnBlYXzAo1IQU4dJaFPcNWiVkFo4v0swlXybs8J6pvtU3zxdhQpvTx6n6BMD82p5FjkwdlwbsiqiqbBQCKyPROUmDAHKAvaAxr2H4BUDWrHKXDPjX5bCZHqINidHdYzd+mGem+SA7QLguOE9advhMOm/IUvRqIUPiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P14KhoMXfGPni5qi61eVjUkVCq90IQqObPqvQa87lCY=;
 b=cimBUg+3QHDKjO1NXdGDqg2AvXpoiM9kqDrinPMXFfxzhSrFFbc/DbY5HnXgWUJ4wUBtuazPsLTmqn5N56odgkfsYurJIlNNUj6xT4UPdMyW29aFrpZosG0/yI6lbqSqAAd2exbag3F5LTaIeUzUhLfyLP47XBjRdSAQ8g3HqhE=
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; dkim=none (message
 not signed) header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS1P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::6) by
 MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 02:43:51 +0000
Received: from CH2PEPF00016D47.namprd02.prod.outlook.com
 (2603:10b6:8:451:cafe::5e) by DS1P221CA0001.outlook.office365.com
 (2603:10b6:8:451::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 13
 Nov 2026 02:43:50 +0000
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00016D47.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 02:43:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:49 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:44 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 13 Nov 2026 00:16:51 +0530
Subject: [PATCH net-next v4 7/8] net: xilinx: tsn: add the endpoint TX data
 path
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
Message-ID: <20261113-patches_v2_external-v4-7-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
In-Reply-To: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
To: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Michal
 Simek" <michal.simek@amd.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Eric Dumazet <edumazet@kernel.org>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rt-devel@lists.linux.dev>, Srinivas Neeli <srinivas.neeli@amd.com>,
	<git@amd.com>, <neelisrinivas18@gmail.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00016D47:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d0f16c-717d-40ba-c14e-08df412ff2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|921020|10067099003|11063799006|261021123027099003|261026121527099003|261026140227099003|56012099006|261022105027099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CoGM6xgD2wOEankpt+uizDMXHTbEnCa8iMLXWqpG5/Ln5Y0tSePQ+NTt5jQxucrCLCzNM/Iw9IbGiQWSOWKhCYimtlcDV9ef0MC8Y9fAU4GsC2ECdCBtkkBhkpHjlEnqjwIaKxVEiujz6GDQp5S7O+Lga4cxUuDOkcuYKFZ/A9jl0udpYoYGHr7VGxryTSMtSTYoWDCW3baagNsgNB+3+FOa/ovUEPEcs5j6qWuj/N8J35feEIww4tYJVSEUjf+3FnRoQt0XtA6HfkE6agRz3JouN7s60ErVM+GvcVnuNexKLAi+R5IlXli/Sz0F1IOEN5zsJ8kHaLOnKZRJ+X73yNV77EaFplt2gVlhKAeQ6dG5rKkmtB/U5WUMC/xVjcQ0I4GFl6RLvkTMzYqLVW309YTcVclBAeORPikO0e7YAE/+a9a6G7Lcv3I3T5Zl/j0xT6sJ+DeynsixsIycL5n+J80Y7R2ZiaxHEzUv2CxKhOYw64Ol8bIe/b8HFqb77NQTRrJI2PN2hDyUPJiv3VIkf+S39y6VSD5X2NZWoloz3sdgXhItCrZeTBXbI28EEpRHD9x0peizFjwQipW5Ar6sZoBxxjxO+eluOQ35lZCi49OMnukgJHCXXBN5UamQG9F60lzaKw8j6LNfX4Tvg3+1BRAx02wjnd4kJhntyLHEWj5bzBCgeblbkhnk11k1pFUvmkc7x3dIcYUThJHqTsneHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(261021123027099003)(261026121527099003)(261026140227099003)(56012099006)(261022105027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8KYrTqqTpjTk+5kpr5UaYXA1TOPGJ2gf2mv5rfrvvUJPBHpsZTWTKQ+i20IThKpxZYNf2DDaUfCRdwCgxKHBqCyUGwY66c0AtLd9petK0Y+rUo7b1h9+qwd7yfZfk54TZrEdJd+7GK3KwBTYe+T3aldNjXrZjTDkdA+GmwBbmErZg2KI+o9WAK2NwLb4oU6jnHE3MfZfawb1SfkDQ+4X4FHq61z+h15lLuy8u8ZQUUuN5RMGgWYJ25vl8pfUgjmvQs7HBk8WqA3DFZxCOO4GValM9Q+0pNwNOOAU4EH2Z7kIMy6H4hRFA+H87WMYi8cX/QaNuYCM+wByzfe+6cTymTEHG5tE/Iy/D68GZaKIkgEYYs0DhFAJEqv1WJUF0sbtpqZawLymksahGVe5QAUCdFMQWwRHjHhRiQ5KiSlZrIgpTSqXC05d8QCseg2ivgR1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 02:43:50.5383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d0f16c-717d-40ba-c14e-08df412ff2fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00016D47.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192

Add the transmit path so the endpoint can send frames.

Select the TX channel by indexing tx_chans[] with the frame's logical
queue. ep_init_dmaengine() fills that array in logical-queue order, so the
index maps to the channel that queue's descriptors were set up on. The
driver consults tx_dma_chan_map[] only to reject a queue with no mapping.
Map the frame and submit it to that channel. Stop the queue when the ring
runs out of space, and wake it from the completion callback once a slot
opens.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v4:
- Call skb_tx_timestamp() before dmaengine_submit(). The provider can
  start a pending descriptor from the IRQ of an earlier transfer, so the
  completion callback could free the skb before the timestamp was taken.
- Add .get_ts_info with ethtool_op_get_ts_info() so ethtool reports the
  software TX timestamps the driver now generates.
- Terminate the TX channels in ndo_stop() before netif_tx_disable(). A
  completion that read the closing flag as false then finishes before the
  queues are stopped and can no longer wake one while the channels are
  freed.
- Extend the @closing kernel-doc to the TX completion callback, which
  tests it before waking a stopped queue.

Changes in v3:
- Free a DMA-error TX frame with dev_kfree_skb_any() and a completed one
  with dev_consume_skb_any(), so dropped frames are not reported as
  delivered.
- Add skb_tx_timestamp() at the hardware handoff for software TX
  timestamps.
- Skip the queue wake in the completion callback while closing. Use
  __netif_txq_completed_wake() with the closing flag, and set ep->closing
  before netif_tx_disable().
- Reword the body to state that tx_chans[] is indexed by logical queue, and
  drop the description of a runtime channel lookup that no longer exists.

Changes in v2:
- Take the scatterlist entry count from skb_to_sgvec() instead of assuming
  nr_frags + 1, so dma_map_sg() cannot walk past the end of the list.
- Check dmaengine_submit() with dma_submit_error() before advancing the ring
  head and charging BQL, and drop the frame if the submit fails.
- Publish the ring head with WRITE_ONCE(), paired with the READ_ONCE() on the
  completion side.
- Take the ring size from the channel instead of the compile-time constant.
- Use dmaengine_prep_slave_sg() instead of calling the ops member directly.
- Move tx_lock into the per-channel struct, mirroring rx_lock, so independent
  TX queues do not serialise on one device-wide lock.
- Narrow the tx_lock kernel-doc to what it actually protects.
- Mark the ring_tail store in the completion callback with WRITE_ONCE() to
  match the READ_ONCE() readers.
- Use the spinlock_bh guard class in the completion callback so it matches the
  spin_lock_bh() in the xmit path.
- Index tx_chans directly by logical queue in ep_start_xmit() and drop the
  phys_chan/dma_dev locals, so the transmit path no longer re-derives the
  channel through tx_dma_chan_map.
---
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 161 +++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index f179062c7d14..6e2721a74f28 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -28,6 +28,8 @@
 #include <linux/timer.h>
 #include <linux/types.h>
 
+#include <net/netdev_queues.h>
+
 #include "xilinx_tsn.h"
 
 #define DRIVER_NAME			"xilinx_tsn_ep"
@@ -82,6 +84,7 @@ struct skbuf_dma_descriptor {
  * @ring_tail: consumer index
  * @ring_size: number of slots in @skb_ring
  * @rx_lock: serialises @ring_head between the RX callback and the refill timer
+ * @tx_lock: serialises @ring_head and @ring_tail between xmit and TX completion
  * @rx_refill_timer: retries RX refill after an allocation failure
  * @is_tx: true for TX channels, false for RX
  */
@@ -94,6 +97,7 @@ struct xlnx_tsn_ep_dma_chan {
 	u32 ring_tail;
 	u32 ring_size;
 	spinlock_t rx_lock;	/* serialises @ring_head */
+	spinlock_t tx_lock;	/* serialises @ring_head and @ring_tail */
 	struct timer_list rx_refill_timer;
 	bool is_tx;
 };
@@ -112,6 +116,7 @@ struct xlnx_tsn_ep_dma_chan {
  * @tx_chans: array of TX channels (size @num_tx_queues)
  * @rx_chans: array of RX channels (size @num_rx_queues)
  * @closing: set in ndo_stop so the RX completion callback stops re-arming
+ *	and the TX completion callback stops waking a stopped queue
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -311,8 +316,151 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	ep_rx_refill(xchan, true);
 }
 
+static void ep_dma_tx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct xlnx_tsn_ep_dma_chan *xchan = data;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct netdev_queue *txq;
+	struct net_device *ndev;
+	struct scatterlist *sgl;
+	struct sk_buff *skb;
+	int sg_len;
+	int len;
+
+	scoped_guard(spinlock_bh, &xchan->tx_lock) {
+		skbuf_dma = ep_get_desc(xchan,
+					xchan->ring_tail & (xchan->ring_size - 1));
+		if (!skbuf_dma || !skbuf_dma->skb)
+			return;
+
+		skb = skbuf_dma->skb;
+		sgl = skbuf_dma->sgl;
+		sg_len = skbuf_dma->sg_len;
+
+		dma_unmap_sg(xchan->dma_dev, sgl, sg_len, DMA_TO_DEVICE);
+
+		skbuf_dma->skb = NULL;
+		WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);
+	}
+
+	ndev = skb->dev;
+	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
+	len = skb->len;
+
+	if (unlikely(result->result != DMA_TRANS_NOERROR)) {
+		DEV_STATS_INC(ndev, tx_errors);
+		dev_kfree_skb_any(skb);
+	} else {
+		DEV_STATS_INC(ndev, tx_packets);
+		DEV_STATS_ADD(ndev, tx_bytes, len);
+		dev_consume_skb_any(skb);
+	}
+
+	__netif_txq_completed_wake(txq, 1, len,
+				   CIRC_SPACE(READ_ONCE(xchan->ring_head),
+					      READ_ONCE(xchan->ring_tail),
+					      xchan->ring_size), 2,
+				   READ_ONCE(xchan->ep->closing));
+}
+
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct dma_async_tx_descriptor *dma_tx_desc;
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	struct skbuf_dma_descriptor *skbuf_dma;
+	int queue = skb_get_queue_mapping(skb);
+	struct xlnx_tsn_ep_dma_chan *xchan;
+	struct netdev_queue *txq;
+	int sg_len, nents, ret;
+	dma_cookie_t cookie;
+
+	if (unlikely(queue >= ep->num_tx_queues)) {
+		if (net_ratelimit())
+			netdev_warn(ndev, "Invalid TX queue %d (max %u)\n",
+				    queue, ep->num_tx_queues);
+		goto err_drop_skb;
+	}
+
+	if (ep->tx_dma_chan_map[queue] == TSN_DMA_CH_INVALID) {
+		if (net_ratelimit())
+			netdev_warn(ndev, "Logical TX queue %d has invalid DMA mapping\n",
+				    queue);
+		goto err_drop_skb;
+	}
+
+	xchan = ep->tx_chans[queue];
+
+	sg_len = skb_shinfo(skb)->nr_frags + 1;
+	txq = netdev_get_tx_queue(ndev, queue);
+
+	spin_lock_bh(&xchan->tx_lock);
+	if (CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
+		       xchan->ring_size) <= 1) {
+		netif_txq_try_stop(txq,
+				   CIRC_SPACE(xchan->ring_head,
+					      READ_ONCE(xchan->ring_tail),
+					      xchan->ring_size),
+				   2);
+		spin_unlock_bh(&xchan->tx_lock);
+		if (net_ratelimit())
+			netdev_warn(ndev, "TSN TX ring full\n");
+
+		return NETDEV_TX_BUSY;
+	}
+
+	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (xchan->ring_size - 1));
+	if (!skbuf_dma) {
+		spin_unlock_bh(&xchan->tx_lock);
+		goto err_drop_skb;
+	}
+	spin_unlock_bh(&xchan->tx_lock);
+
+	sg_init_table(skbuf_dma->sgl, sg_len);
+	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
+	if (ret < 0)
+		goto err_drop_skb;
+	sg_len = ret;
+
+	nents = dma_map_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+	if (!nents)
+		goto err_drop_skb;
+
+	dma_tx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
+					      nents, DMA_MEM_TO_DEV,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_tx_desc)
+		goto err_unmap_sg;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->sg_len = sg_len;
+	dma_tx_desc->callback_param = xchan;
+	dma_tx_desc->callback_result = ep_dma_tx_cb;
+
+	skb_tx_timestamp(skb);
+
+	spin_lock_bh(&xchan->tx_lock);
+	cookie = dmaengine_submit(dma_tx_desc);
+	if (dma_submit_error(cookie)) {
+		spin_unlock_bh(&xchan->tx_lock);
+		skbuf_dma->skb = NULL;
+		goto err_unmap_sg;
+	}
+	WRITE_ONCE(xchan->ring_head, xchan->ring_head + 1);
+	netdev_tx_sent_queue(txq, skb->len);
+	netif_txq_maybe_stop(txq,
+			     CIRC_SPACE(xchan->ring_head,
+					READ_ONCE(xchan->ring_tail),
+					xchan->ring_size),
+			     2, 2);
+	spin_unlock_bh(&xchan->tx_lock);
+
+	dma_async_issue_pending(xchan->chan);
+
+	return NETDEV_TX_OK;
+
+err_unmap_sg:
+	dma_unmap_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+err_drop_skb:
 	dev_kfree_skb_any(skb);
 	DEV_STATS_INC(ndev, tx_dropped);
 	return NETDEV_TX_OK;
@@ -343,10 +491,16 @@ static int ep_open(struct net_device *ndev)
 static int ep_stop(struct net_device *ndev)
 {
 	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	unsigned int i;
 
-	netif_tx_disable(ndev);
 	WRITE_ONCE(ep->closing, true);
+	for (i = 0; i < ep->num_tx_queues; i++)
+		dmaengine_terminate_sync(ep->tx_chans[i]->chan);
+
+	netif_tx_disable(ndev);
 	ep_exit_dmaengine(ep);
+	for (i = 0; i < ndev->num_tx_queues; i++)
+		netdev_tx_reset_subqueue(ndev, i);
 
 	return 0;
 }
@@ -366,6 +520,7 @@ static const struct net_device_ops ep_netdev_ops = {
 
 static const struct ethtool_ops ep_ethtool_ops = {
 	.get_drvinfo	= ep_get_drvinfo,
+	.get_ts_info	= ethtool_op_get_ts_info,
 };
 
 static struct xlnx_tsn_ep_dma_chan *
@@ -402,7 +557,9 @@ ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, struct dma_chan *dma_chan,
 	chan->ep = ep;
 	chan->ring_size = ring_size;
 	chan->dma_dev = dmaengine_get_dma_device(chan->chan);
-	if (!is_tx) {
+	if (is_tx) {
+		spin_lock_init(&chan->tx_lock);
+	} else {
 		spin_lock_init(&chan->rx_lock);
 		timer_setup(&chan->rx_refill_timer, ep_rx_refill_timer, 0);
 	}

-- 
2.43.0

