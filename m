Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C76286430
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073353; cv=fail; b=Tuc6dbWJ/DIz1D/JBYNKOMkkCOiypWmHHbOKj9M5JvYai24yf1yCDfG/uovVb4VCKB9truJEo+SlEHTHngqdvB3JWu3tvWqgmHPuv6svJSuB7EnVqXtZzK0416OAvhT7NFhp7TqKKt5Z6WJIRW634TNGmgm2DSHz/ukzCVe8rE0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073353; c=relaxed/simple;
	bh=bKyxZ+QQCtGeDv4acqQpCd5govZx+ybynVcZN35DBOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7nJsn7+88Zdxge7HZjBAXGs0xS3pgJEGAk+Z2ukNSTFgFAnqG/7iowSA0q1kWBduwpKnL3G/B9KJZaU71Bqy1LjokH3BJpaNCV4fre0zXC+LobCDM32PxjNDLbnwYK9IEf3UttyOIR0bdsWhq0coun6K8tSurBPUTVt/DGvf3Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fXx4KNoW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fXx4KNoW; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fXx4KNoW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fXx4KNoW"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=g7Gofu6lp4ghdbrLG3uSAILFNWHUEruwbG9v5GWlXt8o5Y0dkJ6sQCxjrAHrAUZcD6tzGeND0mkfCrFffWL/WIClhCmCYy1TsKGd/cL+JW+ccOhYe7r5wpF6kRIKnxNnBe0DIxSZhuUjPyqvH171x3dUPYIktgw1lmfrR7Qb2vMwfuPFlL+RFaf0fYRkbN5h+t3ZMk6fVEI4PNZez3935XqUpd9PAs21wKuJGtSRnhaz6Bku0d/F04QhXQ/OpAIMwCLwbkvg12W2v+/x7Gc/k5itWeDEIR5FTUNit1nFV1XSu6U7JdepGrUuQ67irO1LILcOxcMl7VY/ZGhiHBCo5w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJQs9k4obSAH8/J5UDxSYVR3UStb9z+eWCYk17Z8zr4=;
 b=igE2fWa18YOEzHxFiViaCBvHBdfNiGhIIfPa2oPAB7XZDkxhgQ7lKRFJlEzIYIFO6mP7Om25HrcPodz6pF6DhU0jwDJFvsW6lMUXuelFUJdjfKJUSsGSkvk+Plq4GrJBIne7yz6dSvtIsXgbDz69JZ3tn/t3Y9f26rnejihG87I7xBSvo8cP085yPPH0B5Zid3AWIqAaQO2y0eLaB89dKFQW1mF+Zgeo2UBhHcfmDZgCdbWfw+mLKO29yVrx9Jg9rl+ZqAlSgHSIA+W8n0eX3QGtaDKSXYsUHV2iw/70DGSSWuBSBmnmgvORp3ZEgxke/wqK01AIXNzezI1SsmX1zA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJQs9k4obSAH8/J5UDxSYVR3UStb9z+eWCYk17Z8zr4=;
 b=fXx4KNoWIXxflC7+0UJeYBITBRnfvooGkTBlKpvpf5wriwAmuOIQMUaJQL73957pHCdlT4rWtyMsipGkTLYK/XHsmFjE6f+pAWR2gzIVVzgjgt11LAtEgNGJS/nW/iAB9wjlyhP0l8gHxghktsp9sTXOq/OmqWeAPFKLH+w++Qw=
Received: from DU2P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::28)
 by DU0PR08MB7416.eurprd08.prod.outlook.com (2603:10a6:10:354::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:55:46 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::59) by DU2P251CA0026.outlook.office365.com
 (2603:10a6:10:230::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 15:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via
 Frontend Transport; Thu, 18 Dec 2025 15:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOGwjiTjpVBLB3wxXCbZSTl9pTFYM0JqkfjqcvJRT9ODvALG2psJ6y9YDlYrzBX0nuWuELsAWQ7vSaAhoMHOVAE7qodZbzr56230hnNy+I6yBc6b4dkQAxTuvJVJ+azx1s/lK5ZvfrNZ2b62WYEzLqFC5r6oJ3dklH4GI1eiemk6ZZ4CbDMGShyjZxYYgDQMZJt8VXFed2AGfH4fzvCFABgf0/ptOIOOHhBIUdPB6zdG5vyRtccfCndKBFZSfwGYr3+K7K4YfaBauxpIQeZvQyzpikJbNZcjVpuZqRJi5SbHIC3xSzqxGfE7SSTj1gOTwz+HeYuBnksUTwr0zukG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJQs9k4obSAH8/J5UDxSYVR3UStb9z+eWCYk17Z8zr4=;
 b=wpi8Tdt+D+WiLanaMAO9L9fF5dHWEx4+l8G1+xtZW/xPCN4VpCUSdq/j1ekSUIfJaKYflJ6+0ohkvjXvZYw7stSx3laWI38Rlxk04cbX2Kn19vTRKBJOw89kaoUPoU/82LA/ZtXVFD0UxUrg5L8SoGotAM/zQk2hf6QKoF0zJwwUpy5RaW7FwxmdcLYHLwXxTbjEUXFe+DyhpMMgIMhEVLXXtVjNip766J2N/LAjxRw6nAxMIeqW5PkODdfMQqdWpMTUfPKA9UX5pf3Adjjvwn5iQz1AYBsWYFCy1rriTenTXiUpNUHLxlcTZ3fSnCvEILpFO8/KBFJ5jAXM2zaAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJQs9k4obSAH8/J5UDxSYVR3UStb9z+eWCYk17Z8zr4=;
 b=fXx4KNoWIXxflC7+0UJeYBITBRnfvooGkTBlKpvpf5wriwAmuOIQMUaJQL73957pHCdlT4rWtyMsipGkTLYK/XHsmFjE6f+pAWR2gzIVVzgjgt11LAtEgNGJS/nW/iAB9wjlyhP0l8gHxghktsp9sTXOq/OmqWeAPFKLH+w++Qw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM0PR08MB11756.eurprd08.prod.outlook.com
 (2603:10a6:20b:745::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:54:43 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:54:43 +0000
Date: Thu, 18 Dec 2025 15:54:40 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
	dev.jain@arm.com, yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 1/2] arm64: mmu: don't allocate page while spliting
 linear mapping
Message-ID: <aUQjwKClvatP7zFP@e129823.arm.com>
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-2-yeoreum.yun@arm.com>
 <73ced1db-a2e2-49ea-927e-9fc4a30e771e@arm.com>
 <aUQXRpLzKbl+I3Gu@e129823.arm.com>
 <73644c65-57fd-4d0c-9179-167277214f26@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73644c65-57fd-4d0c-9179-167277214f26@arm.com>
X-ClientProxiedBy: LO4P123CA0638.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::18) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM0PR08MB11756:EE_|DU6PEPF0000A7DD:EE_|DU0PR08MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: b7571980-a0fd-4aec-22d1-08de3e4de7e5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?CatGOoR2aJy4bMz4myRZryO80MAXe9N9loTtpB0ocZ5T1yXzymregbs3ZLig?=
 =?us-ascii?Q?q4rTpru7WdU71f1F3WWob9LVu4Yx6KubgRJsrgUcSOAaWi4waIdb7VLNIYwV?=
 =?us-ascii?Q?YCFlZKHxzZ0RBYQOxdMH5/3XoWRH4Q+cI1TYXvFdLCbhKcx/sURUwS3WxpKk?=
 =?us-ascii?Q?yNRE3PhyX2j6nP7+T7ak9g4FSnPO+hl5xWpQARBZ9kgTq+VoieCen++3LjdU?=
 =?us-ascii?Q?cxXut3N8L18i9P90sxsOrFZIoUn1qNHcjQqrDshN0i59hwsby+vRZIWMov+H?=
 =?us-ascii?Q?z9gi13P8OStkSmIAo1dTVfxY89XB7Sml26vl14RHOYlGEiFnd3TC77ojauWG?=
 =?us-ascii?Q?R1CR1YYgxFn875zVjG8aipkpDi6ek9ns83ZK8B3Gy4PDFX0LjUJz69fQ/P9B?=
 =?us-ascii?Q?WiDp1gy8fQV+ngx++I9f6AZSj2OGlj6rs7L0lVxxWANJ6IjRTj3KMniE52tC?=
 =?us-ascii?Q?owKu29BYeB9qnRO528NLVMJr3gMh3g/chcd4CHdBJZ0EpOIK2Jy4VrAL6wCF?=
 =?us-ascii?Q?G9O9iXWNfN6sAiIf6/kjtkwWUXbytxGyRMz3RxWaf00uqHmV3IkuJe2zIMXl?=
 =?us-ascii?Q?NjOrqxuBTs2UQ/vL1KPk2yNdLcUig+8TMWtNJwACa+u0WAhB0eJtA5U2sHWo?=
 =?us-ascii?Q?0iSAEJnBOoyeau91V0iMn01IZhyZi7+/5RR3JZcfSzDz4jXI4xm3j8qMTrdL?=
 =?us-ascii?Q?1449qYDJFv0MPriwkblqllXVcag77mKntKDLl6/LZak3wuTeRL1iqS7daszu?=
 =?us-ascii?Q?mMMGIkw8+0fk7BbmZ476ojyFY2i59OCo9FjsriITxSp3z7lbyN57Y8WsY0sM?=
 =?us-ascii?Q?ybpD/nZ5WomBLzaPE7DiZdgnzryzYWV5qXtOrKqitAzSsuB7TNUmOh9odeDX?=
 =?us-ascii?Q?d8ecjAtEv2F/COOuFOMcl3Bh6by2DUA55h3qjsavFUou0OrO+b0Dbqa03kAT?=
 =?us-ascii?Q?HnDEcj1c+0ZBcHCLPnNLzL4ErgWht7Pem9UV2+FYGeQ3m/gNa5Qc2VspXu3y?=
 =?us-ascii?Q?I56L63K0FlkcJ/XofAvBikq0Vc0+1FwDMWyZaJNdYWI7rtV7BceSXMvxySq3?=
 =?us-ascii?Q?a0jPveJOQcF41L9rElvTJgRNnGoPCW+EEZz4Zzs34r0LZLTp2KNOuRjPy5ft?=
 =?us-ascii?Q?pxFmVc5u2ehOJBvp26pxX6wq0tmS98n0rOU7+0UcnCD/nAd9KzHMSAbiPQH0?=
 =?us-ascii?Q?llgknONfvomob3uA6wBeZxErYBLCRmRhJV0Fft0NWNg/8oOVjkksjI/tsoy0?=
 =?us-ascii?Q?n1GuktjVZg7I/oy9+MM00LrcA9q826Uz8pF5E/3zeMUI1SQWoJR9FrNuS03+?=
 =?us-ascii?Q?z+CkkAx6jHRIZ/YmQp0EvxaPSyYb1QjIynSnonovJt4RVNwEEJUrY8tuoP2O?=
 =?us-ascii?Q?iN+glNXp5WZjH6VCdj2XmtJAPycUq/rJzK9Pe7vQrUCPi8N8z/Z8tV3cctCb?=
 =?us-ascii?Q?Sr+XY2QieQmaVfHNB4wxfDTLU0iQyxUt?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11756
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8406f044-2ca8-44e4-5203-08de3e4dc297
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|36860700013|14060799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N0mmWN36VeobXROegPsRUQ3nAVOeII2yby1pdEJjbJI7sKH2HUgvpBUb11sm?=
 =?us-ascii?Q?iH/S6t82MH1bTJvHc+u4Wa/qt2sZh3bkBxkjhEBBsrCY/RZmXH/YyaVPEn5i?=
 =?us-ascii?Q?BSOKNUy9kicoiitesbV/0ousVbI+6vLTptNl8QUCEMkEs1hNq6jCuPLOVdA6?=
 =?us-ascii?Q?u1wM6IJHNYogjbbvFfr9Qw00rDtBo8lsKgVA/pziunbpwHdF8GObhCCDSI27?=
 =?us-ascii?Q?ZeVK28m8zuhV5k04/4HVKp5mFbUkf2n8sXBkzt/tUAxjRP+zm681vviZZrdm?=
 =?us-ascii?Q?g4fsmQ+QdaDvaQQLQiXAO0xm9YYerwL6330Yl2xnjdIkzYsw4yAUt3Z2IAwy?=
 =?us-ascii?Q?Ecza2pR4fnJ3uHvdA5pJCObF1hIYgadr/7OzWjt2QE9ylb1dJSMGEtxx76MX?=
 =?us-ascii?Q?eZTV4DT5IMSdx/acnX3KPYR5k2PQNykn64YnXI8s8+EO+NcsnJ0XqoHtirg2?=
 =?us-ascii?Q?BXNpSVaszeshrNYsM2oJryTsan1gr25u3ghy0/h7dQ8A7a/HyfW4erMROuax?=
 =?us-ascii?Q?T3GWVL2cz0oqUz1aZYub9nsPw6QZTk9YIVuXJcahGQZIdwm+F33WAqn4JVND?=
 =?us-ascii?Q?HFw+sf/YPnGUOdQubf8O53Bq7l8laP61qAaSFq/ejyE0KKglbNGUtW0Tj00r?=
 =?us-ascii?Q?zVBKqvel3YLjeyZE21Gbf51SOBktO7dPAOzgWa8O/RXToyP4T4kUYRE6/ctX?=
 =?us-ascii?Q?h4bmX6lqZeJrO2UFIgx1oZed19GX3FV6IwRBNxfyDD9NzANZmsSRpMjgUV/9?=
 =?us-ascii?Q?5GHwNg/ujWG5PFVeLJ8JJibaEFuo5SfbL9fYSerWMOmgt67H8SZyxByRPcjZ?=
 =?us-ascii?Q?ijoBa9OCB+C3bWNtYzTaZoY53y4EJgCiUTSNp301DF8hRFybS2Zz4+06Buei?=
 =?us-ascii?Q?478dqAV4EWSaxtL4vTucdCbmCli7moW70mtZa5C2XTO/sRDgE0xI6KU08blO?=
 =?us-ascii?Q?xeymmhukZkViJlGsPpfkMPsfTOC8JP5htbhpY6px5x5YZT6t1jNvOZ7y5N3U?=
 =?us-ascii?Q?Wvb7Uk6BoK2r2WrkmBFxQQsXeeYiiivYt2znx0ltUzP0Xp5eqX+shkaRphw0?=
 =?us-ascii?Q?6Her+osmKjTlQWfn+rq+MBgqZufUkz12DLjHCYudmiM32NMxg9Ify25DpN0A?=
 =?us-ascii?Q?yqmyZ6E5Bmseb1mc3VTi8ulVinIO9QDFxd5rvG8OUPESTQyaacvm2k9K/8v1?=
 =?us-ascii?Q?a0VoKKzXh0GQiMG6Vf3ZFx7DPuTnhFQa7XfoaNcF+8jM+V9akD3G70hXQpvg?=
 =?us-ascii?Q?rNncAZS7jTXSjI/X4sTZXTcrNNd+SAbCzl1NZd1MjBsXAr49t6M//H6Tfx2k?=
 =?us-ascii?Q?LCYmHVMpSx4aMu6Vh2xjZRcojCPNmxtsvB+VyJFjVF+qBrMQlYTfBevHnbbN?=
 =?us-ascii?Q?roITo9cpC0/okPlD1B9r2oZvCXoWp4WtsNa2LUil/HXIV251hVaM6kauTY8U?=
 =?us-ascii?Q?hua7k+fJV0niszmNEb3xpfem53IOeCih2IUWww3VxiShdyLNjWJfZzgSFU1i?=
 =?us-ascii?Q?8kNOWbuW94VJNb4J5Tlwwq15O47w2FfmvVvcmcOK6BgN0vR4vLqeJ6n8vJ70?=
 =?us-ascii?Q?vd1nX6Nua1i5+/slRLA=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(36860700013)(14060799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:55:45.6139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7571980-a0fd-4aec-22d1-08de3e4de7e5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7416

> On 18/12/2025 15:01, Yeoreum Yun wrote:
> > Hi Ryan,
> >
> >> On 17/12/2025 18:20, Yeoreum Yun wrote:
> >>> Current linear_map_split_to_ptes() allocate the pagetable
> >>> while split linear mapping to ptes by stop_machine() with GFP_ATOMIC.
> >>>
> >>> This is fine for non-PREEMPR_RT case.
> >>> However It's a problem in PREEMPR_RT case since
> >>> generic memory allocation/free APIs (e.x) pgtable_alloc(), __get_free_pages and etc
> >>> couldn't be called in non-preemptible context except _nolock() APIs
> >>> since generic memory allocation/free APIs are *sleepable* for using *spin_lock()*
> >>>
> >>> IOW, calling a pgtable_alloc() even with GFP_ATOMIC
> >>> doesn't allow in __linear_map_split_to_pte() executed by stopper thread
> >>> where preemption is disabled in PREEMPR_RT.
> >>>
> >>> To address this, divide linear_map_maybe_split_ptes:
> >>>   - collect number of pages to require for spliting.
> >>>   - allocate the required number of pages for spliting.
> >>>   - with pre-allocate page, split the linear map.
> >>
> >> Thanks for working on this fix!
> >>
> >> First some high level comments: I'm not a huge fan of the approach with the
> >> different modes to modify behaviour.
> >>
> >> For the first step of figuring out the number of pages required; there is no
> >> need to be inside stop_machine() for that. Can should be able to just walk the
> >> linear map without any locking since it is created once and remains static, with
> >> the exception of hotplug, but that is not enabled yet.
> >>
> >> I think it would be cleaner to just create separate walker callbacks rather than
> >> repurpose the existing walker.
> >
> > Okay. I'll repsin with separate walker.
> >
> >>
> >> Then you could simply change the gfp flag to a callback function pointer and
> >> pass the desired allocator as a function pointer. This would match the existing
> >> patterns used in mmu.c today.
> >>
> >> The preallocated page list could be stored in a global static variable and you
> >> could create an allocation function that just strims a page from that list. See
> >> kpti_ng_pgd_alloc() for an existing example. That assumes a contiguous block,
> >> but you could generalize it to hold a list of struct pages and reuse it for both
> >> cases?
> >
> > If we use walker callbacks, I think it not only pass the callback
> > function, but it need to pass the gfp flag too since split_xxx() is
> > called by another functions. (i.e) set_memory_xxx()
> >
> > I think I can remove the mode with the suggestion of @David
> > but, I think it would be still use split_args with information of
> > gfp and preallocate buffer.
>
> I don't think that's necessary; all other users pass GFP_PGTABLE_KERNEL, so we
> just need one allocator function that allocates with GFP_PGTABLE_KERNEL and
> another allocator function that allocates from the prealloc'ed list. Then the
> user passes the function they want to use.
>
> That would work, I think?

True. I forgot I removed GFP_ATOMIC myself for pgtable alloc.
Okay. then I'll move the preallocated buffer information to global
and just pass function pointer then.

Thanks


--
Sincerely,
Yeoreum Yun
