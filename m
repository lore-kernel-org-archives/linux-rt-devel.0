Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1A32BF5A
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514027; cv=none; b=dFv+GzXEJoeKEYdYyXItqOh8UKzWS1+iuoXvQcmaj4+eFrNdVSDXnbsoo1oPVU8UaJEgNzRkhmA7+kV4zo8dN8I7KP78rsEOsTtjZ7mbkWTbNfsRZx59+R6beDwWsPt0/kYCiPfHFdduo1naDGAZnMDdWMbIMQylNvPC7ILrqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514027; c=relaxed/simple;
	bh=yRn6gRtMLiLqMDInORTTYh92hg9HUS6B25U23zwFj3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d39BHZHkeu9wtNyznDEHhV8RLwrnkwwIDj40Ws8tLZC0/OtWzbjYNfByeoU4BCHksHbxKXY6rldPjB8Jr3ZDFd2IRgrQcafdavBywbQTZkBv2hSy+sElJT4LpENQBWo71F/4SdLa+bgu8UPGiiY0UrbEKIa8R5j7xyP9rmaANfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Aug
 2026 13:48:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Aug 2026 13:48:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 12 Aug 2026 13:48:28 +0800
Subject: [PATCH 4/7] EDAC/aspeed: Free the mem_ctl_info unconditionally on
 remove
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260812-edac-v1-4-03992edea297@aspeedtech.com>
References: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
In-Reply-To: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	<linux-rt-devel@lists.linux.dev>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786513706; l=1411;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=yRn6gRtMLiLqMDInORTTYh92hg9HUS6B25U23zwFj3o=;
 b=ssnqIGmszPrfSMHYrqQ49TZhae/h/sTZ3GwA+RPn09RCCbhAP8Z4KVb+OO82ZhXy0cfSsUYep
 CUzsPZknQkDBRQ3tiym0RwK1UG3pJ08zptxQkKqRDJFr1s955CD26o3
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

aspeed_remove() is a driver .remove callback, so it only runs for a device
that has already probed successfully and registered its mem_ctl_info. In
that case edac_mc_del_mc() always returns the same, valid pointer, and the
NULL check on its return value can never be false.

Fetch the mem_ctl_info from the platform device's driver data instead and
free it unconditionally, dropping the redundant check. This also decouples
the teardown from the return value of edac_mc_del_mc().

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/edac/aspeed_edac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 71535e0b6bad..8bfeb21d3204 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -343,16 +343,15 @@ static int aspeed_probe(struct platform_device *pdev)
 
 static void aspeed_remove(struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
 	/* disable interrupts */
 	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
 			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
 
 	/* free resources */
-	mci = edac_mc_del_mc(&pdev->dev);
-	if (mci)
-		edac_mc_free(mci);
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
 }
 
 static const struct of_device_id aspeed_of_match[] = {

-- 
2.34.1

