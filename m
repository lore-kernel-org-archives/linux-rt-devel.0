Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9084E1C
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 Nov 2024 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775019; cv=fail; b=DwnuRe5HN+oA57GAUZhDdF4ILOb1k/ao7pDuNmco/COrJLgNQr9RHk7uYnZpAAjlHT4umFnQ8ATC1JbZ5HXvOTLah0B1TlTvkoDf4gwBcve37iXMR1XpJH7MQV6Ujg5RsxtyRT3wiggrHu5rq51LF5vuktcLX1RiBDxjEd7xy94=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775019; c=relaxed/simple;
	bh=la0VFwEfOAWorGt4SbPWkCAnXN+lgGCBJQTxs/MHHiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dC+k7uUN1VStd8dTrUUN7j8FPtRki+F1Rc8uAoOLQH1dVLMAXYovthLxWt/KGfaQUTbgcdK5kYjNDkNbhxXzRz2V0cflIcJyjbO8yCFKnzNWTUmIPfz7ZapNg+dqeKzLdkrlsVVgUrMsj+TR0zN6JQk0Mokd8qLGQwXN6Mk1GYk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZS6SOQo2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZS6SOQo2; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZS6SOQo2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZS6SOQo2"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=W/s6ANWyg//Ppka7KbxO/fE5r9a6fK6C6HvRn8gnePtzI4QYf9A15ZfYL2+NPk3xNZgtAcz4QYJ31eVsDE0T9KSr2UIPLhT8Zhr8xnungw1srOKFyixn83oxr2V5GSvmWBx+5Dzcwbriyqanryfky244smb+90LzouY5hszXgR5qzBogB3ukuAny6Y14STfbVoI5k1/LJwUO0YOYfyVj9Vzzze7+hjU9V3EAibTBAeF52c2JmGut4MIZI8cf1O5ZQvA3Nd7aOmXVm0WrCeh5CTK9CHN7RqVR9VK3vCh0fXPnRYoY2MUAAb7KowsmxivNC5+3upDYPlJK6e16u/2/JA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B845PDujJZA2/PooLgD+a8zkPUg1aX618Fzlgyw05jE=;
 b=uLm9zVwvzuwV+7a9JUGNWVCKdYdPncZ5+dFA9y7u6SWXG7oSoc/vpSmqQaorkCajA72mJ9ORZC3GEGuKy2qDSKnWNrwFXmnKGTGX4DipJSohYDThO31pxUBLAH8yv6ER+SC8nl/7BlBW7ZUUZrJblqvD8UJ9qyHK3CR4L/xOVqLdsC9S5KTjlclMVEp27y29XL+ZdFnqJkNcIo7uQtXDt4oomF6iCTkoyYO6IlZliYszQgVU1MB0i406hkfiTzj9uSIkY3Nk178dWzqM4FBB6AJd7UZQL90u57AcaNSdVPCi7PtVdg2g738v4rQ5f3Ya53FWOTWn4FnmlpzuxPlSYA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B845PDujJZA2/PooLgD+a8zkPUg1aX618Fzlgyw05jE=;
 b=ZS6SOQo2vAQ2jiVfvHlJNO/ntuYBNCro9A+gFDHxwnSSUoRYjIBI5YIilG82lSDQ0FS+j9R26YA9fS7zVfg67M+pBNrUqJtWW5Ikq3q4oVNW4jkgo2Q2/hPDVsbh5JV6pDDmzZJ2IP1Vm38LGMLeEBB3Oe/u2aTga0ih7PtvYZg=
Received: from DU2P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::26)
 by PR3PR08MB5833.eurprd08.prod.outlook.com (2603:10a6:102:81::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 06:23:30 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::64) by DU2P251CA0019.outlook.office365.com
 (2603:10a6:10:230::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Thu,
 28 Nov 2024 06:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Thu, 28 Nov 2024 06:23:28 +0000
Received: ("Tessian outbound 5b75617ec243:v514"); Thu, 28 Nov 2024 06:23:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: db5955d616ebdeeb
X-TessianGatewayMetadata: Rc8PV39BqiggdIQTS8Vudkj0CP3bfkkYYdjcjDlba+G0vC+kejbugkfdMeqleAVr+R2sSIdUy+91gbtqpZ40gRanI4eSqnts20NIMc0me4q0Y1ETixtcuEdLUVwC8vpcOp2KhDqd7f86SLXT96bmTawfOPgSN6VAqquBVdkX3L5iqAZeOqzcsDbddD3567CEb+nrefs8633n8H7jP8m0xg==
X-CR-MTA-TID: 64aa7808
Received: from L2f045e2287c3.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 381FD8D9-87F3-4362-831F-3E42D3D9A737.1;
	Thu, 28 Nov 2024 06:23:18 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2f045e2287c3.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 28 Nov 2024 06:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nkqde/YoUiDCxpEUVdvI02JtxAzwz1rb/ezKlOxzsmwenQHJSlMliqP0StmC9Ongz6NGpccLjUt+UBTgaDNGKTa9hzJzrNuuhnv0FqxltriR4fax696faiE4feusGVhidwnXcz7uxEF7zOxgcsrVZjYinLp8UjAz2jR7Wx7FhzJL9aifVq1GOgkG8A8rrLWSvdmd9lvQ7delA1/DUVCaNtY7Ni81Oz9K3c6tnYqVyeUAbkIcVo4ej1dLmVYc3qDWM1tb2/LtTmrY0bqoSvRxsApwfM2KgEaPdcVygFHIlCjCG5WzRkNIcvVpZ2btAVA9WbOqA/NyethmIjDWD+MWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B845PDujJZA2/PooLgD+a8zkPUg1aX618Fzlgyw05jE=;
 b=Z//n+oR9lEWaJtTRlVInZE23rtfjVGzJKAs/9L5N9shXZInR9uva7FyOPiutxiDPXtisy2aAK/I8RAVca+1zl4iT/qmc/1iIYZ5YZGIiT+TP1LsWEu1emmQx+yYLsDfdfjr0tAdEHTZlcs1YKxldgsY9oKAa6p2S9PU1E39ZHqiRKRuHF/Jl0G7UcMkjSrE2rD/QtC/BHqV/mcL376osxiFesSIX6MFJl84y6p58/FcByCxum9DGjxhtdawOs3bkJCRYkrICPkud6CNI9g+8gebJKCjgVp5KTiUGWZMgUNDOHDB7hXe628N+7mizZG076j8DQKZL/SLQvjFlmg7r4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B845PDujJZA2/PooLgD+a8zkPUg1aX618Fzlgyw05jE=;
 b=ZS6SOQo2vAQ2jiVfvHlJNO/ntuYBNCro9A+gFDHxwnSSUoRYjIBI5YIilG82lSDQ0FS+j9R26YA9fS7zVfg67M+pBNrUqJtWW5Ikq3q4oVNW4jkgo2Q2/hPDVsbh5JV6pDDmzZJ2IP1Vm38LGMLeEBB3Oe/u2aTga0ih7PtvYZg=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI0PR08MB10798.eurprd08.prod.outlook.com
 (2603:10a6:800:211::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 06:23:15 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 06:23:14 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>, Suzuki Poulose
	<Suzuki.Poulose@arm.com>, "mike.leach@linaro.org" <mike.leach@linaro.org>
CC: "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Topic: [PATCH 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Thread-Index: AQHbPx8wr3p+WgsBJEaSjUrN0UERgLLLWRsAgADY9mQ=
Date: Thu, 28 Nov 2024 06:23:14 +0000
Message-ID:
 <GV1PR08MB105210FEE951B6331F48CF6CCFB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
 <22ef761d-7a9c-46a2-8d61-3d16c2188c0c@linaro.org>
In-Reply-To: <22ef761d-7a9c-46a2-8d61-3d16c2188c0c@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|VI0PR08MB10798:EE_|DB1PEPF000509E9:EE_|PR3PR08MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: d461da7d-9024-424e-a260-08dd0f752c9d
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?oArepz0AHvUorkAVihbHyDx1aLWT/P4CelSiPiSzf8tlrtsdiYkf+sm+yg?=
 =?iso-8859-1?Q?00U91Sp9MkFRyIMsZz62fpaqCpN44g+lgj8VHBrsVQO6BpQnhHOhRE7san?=
 =?iso-8859-1?Q?9BQUV1278stb3LH+6rY7FixkoM+BZKw23tJmO/6/VOsQP724rAlVfQ03ij?=
 =?iso-8859-1?Q?3z2tsi6yDfFqIX4rHY1fYuz47GpaPrsUb+cg4fV5xiTzaEwVt739l4+kDK?=
 =?iso-8859-1?Q?S1MldVdAaccLYCdFWw/S79h5nBGO55IwbeqckyNAd7RFZgY1iAIxKvNDIK?=
 =?iso-8859-1?Q?FaxewkGuRF6XBEwiM5pMZAh6Wwb2PvhYiKzEBKrB43Upsc8rlWXwdOHIJ6?=
 =?iso-8859-1?Q?7HXsyhicmL0X83t3REkINzSyWiq+K+Dber0sRhWOXG62FMOL/aOdJXqj/d?=
 =?iso-8859-1?Q?aeqeB4+udnnrGDWLyM5AuwX7kuloK1zb0BXgepEo/EhK7/Zjgzs3q0MV68?=
 =?iso-8859-1?Q?8cRFfWxGLwjaGwmOjBGhW/zwdAloEI+xZHeEGZrv3TUpi2Vp/ljhLFmt9S?=
 =?iso-8859-1?Q?QbiylD+29ZLWfL/XyWEr+JtH/vm2fGywNv17piXQekjfSYqWr3zbt6KGaL?=
 =?iso-8859-1?Q?pvx2wYr7vRK0hI0NSaO444zP4IEbpMm2gigN7ZBUKj+AegTXBE3ryg8bW6?=
 =?iso-8859-1?Q?W0nt97O+v6EUvNzOERNwgbEq7xfXvWs0izGGuvrlLdchgzbT3eYxGXUEcm?=
 =?iso-8859-1?Q?MGPETeGERxQfdUy+1a2MdCa0U3L4tgZivrjAeY85y1vUJmuMD5s7WTi6WL?=
 =?iso-8859-1?Q?dFa3A+uHJ03lPRV3CN4FHlnFhQUFp8N3wooX/dC10dVTZA+pPpKc9MSnIZ?=
 =?iso-8859-1?Q?IHdtWRWQZhgYIKrh7P1liY7+t6tS/IeLSwAhKw8AynOrqSBH0vG+uKltTE?=
 =?iso-8859-1?Q?LeaPKcYAeeFDtUjnB9rllgolbrywRSxgTyarOnCFe9QLnhkT1c5OK5GI9q?=
 =?iso-8859-1?Q?EBGTcfE93cmP/YvXnLS6wwGlM2Rld6ufWx4PQtW/JGj5ufP3p6fLTftPB5?=
 =?iso-8859-1?Q?ToRPAj7F7M54zqX/wS6qBtt3fiJMkICSeHf8ZwSOJkNTi2C8d1/OAooXka?=
 =?iso-8859-1?Q?TsKTpzFSu3bDE0XHIhXNpB4so6zPTIgbbb4HLtfdoIm0dwcaB6e0FpvF/3?=
 =?iso-8859-1?Q?/NyuF5tv2W1lYHDJyak/L2ONbRWjNYfEVv1iKEU3bOUFaVx2RdMwZIJkU9?=
 =?iso-8859-1?Q?l1SEfasiZybvTMiT9545zUtit3c/0G+AUlTEdixyLTPEiMy/Y0gnjuEytp?=
 =?iso-8859-1?Q?+CuPJEknY1oHGl5eHukTMBD+opTieEoLhO4tPhkBt+wTvZx/9Y3IIH0QqL?=
 =?iso-8859-1?Q?7BrXU1x46w1fu+6t3Pg11yZ2R/f+1RU0wqe3DLwViYBjWOisuz3Xp1gwT7?=
 =?iso-8859-1?Q?lfmJqgUTHTCdZugPSbO4ENjrZ3MqCXOic5me7GOoyVW02hLmeiBng=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10798
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	03d00084-f778-4c69-265f-08dd0f752404
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ySRDQ30PGdddYWVndVnk9vV7fO8U2OX9iepqRf6NQTQ77l58OksAU59uA5?=
 =?iso-8859-1?Q?Rp3bUH3R2YPGDYX08VaN8PuVhXyQHTMGQJRIHspmtMDcxi6vHFB4lju+AI?=
 =?iso-8859-1?Q?1xNsSodiF4y620TJZv4iqoXhh9nltHy/4oz1tSh8yDXdladi6C2MwZnkLe?=
 =?iso-8859-1?Q?MGUuH0nUM06dBa3VfpMkZdrntK53kLAi1vVlWyvRa/EbhxrK9DMUiM1Kie?=
 =?iso-8859-1?Q?v5aulgVuS+lBPQiOnhTpOOabfdzNe/AM0V+UiGKb9nPWvZ9oEWDQuOC0i5?=
 =?iso-8859-1?Q?xlpzcqNeYIX/sFe4INb7tKlu/zfAey+BgpYOxI4FXU9+4DNFsKvYvisfDI?=
 =?iso-8859-1?Q?4dqnFTtjnYmzD1mxjOKrcUisrABXxEVnvqVbQuRvSDSQ7cARYFDQuiDe+P?=
 =?iso-8859-1?Q?x3uVog2zbPUTegn7oS/HNdZPXx7aEAueZY43xMKA9pN8w8uhBzd/m8Cfcg?=
 =?iso-8859-1?Q?yiqjaSy9zwqTRINYiIVQU2LIsbFLdvNehgN30SSBXkN/UsE55HiXtIvRtX?=
 =?iso-8859-1?Q?FzgKia3Gni4t4qqSsFeZX71ev/b5meHOzvOYpYd905d5vcFrGHsCwFFuKM?=
 =?iso-8859-1?Q?AN9Fauncl22Mq+K62ZkaFhHddD0kWfHZTm2tZ+zhGz8i7hpoFJr5K98f5h?=
 =?iso-8859-1?Q?W3TLQtnRN5nbCNYZgkD6LfadoxtJqerlK4Kh3d7i2dWBSA67lc/46mI9OZ?=
 =?iso-8859-1?Q?lJ6qZf1bIs1uxaeMNx36Zh2b8HBmNfNf+rysGuRFmXPKqslA+z+CIFZrWm?=
 =?iso-8859-1?Q?OjpQ8tzu1SnDlgMWlxFmdxpAdkrl7DOAvA46MENdi23V8bhor60bhhWy1X?=
 =?iso-8859-1?Q?DzU3JraWTBo357LMZdymcuLW+s8fLax9e3UwyTcuK1F933gRa5YsO5zPmr?=
 =?iso-8859-1?Q?wWUzdtqB8DaWToywMkCCUwl2j0Mw5VE30lmEgJlN9bdqquVTa4q/oVq6Ap?=
 =?iso-8859-1?Q?iF+nJjlhDdgblcq7Y8ADBQu3CKVp/2Kpdhn+eKzwJ7YYmDSYMdebLNjtxL?=
 =?iso-8859-1?Q?pkzcyi/9a9RoQ8d2vkvdwlMBbQOPgVjukxs7tQkj7v/CT1GatBk8x3GuC+?=
 =?iso-8859-1?Q?Wc4QrWJmjJ3Ij9vwbXomL23gmB6jMkUJ1vAEcAIb5stBW5ZKq3bWUlTYJo?=
 =?iso-8859-1?Q?qNYsORFc6jmIJu9k+VZc80GiVZD7F97RUjXDBCpfG69Ptu9KC3feImzdS9?=
 =?iso-8859-1?Q?puujBBC5+EEKTS/XO+Agl/PqwwXbV32NL1FR3OK/tNI+LpcUMQTRyXZlvp?=
 =?iso-8859-1?Q?vYgBe/aUv0ie4HX11Gy/SrehY6pHE4f9vC90xhzc8EuQlALsfrts6kkL2H?=
 =?iso-8859-1?Q?mmjgh/xDF3Ieqd7oH3opPRIl8NYMxNwsC9w1IGC6bGHJ+aInfz5PtD2OeU?=
 =?iso-8859-1?Q?KymOpP/ofFEnM1h3unE40CJBotjFmEoU2Fnx1zE1sIvy1XgtDa07ccila3?=
 =?iso-8859-1?Q?AkqcsApQAmav/ihVhF4lUBdr9+Q0wpQ6Pqf9Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(376014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 06:23:28.9971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d461da7d-9024-424e-a260-08dd0f752c9d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5833

Hi James,=0A=
=0A=
Thanks for your review.=0A=
=0A=
> Somewhat related to this change, but not something that needs to be done=
=0A=
> now:=0A=
=0A=
> All of the spinlocks for the syfs store/read functions don't need to be=
=0A=
> raw spinlocks, or spinlocks at all. They're never called from the=0A=
> scheduling code and can be locked by coresight_mutex instead.=0A=
> coresight_mutex is held on the sysfs enable/disable path when those=0A=
> values are actually used.=0A=
=0A=
> Same point as here:=0A=
> https://lore.kernel.org/linux-arm-kernel/9a637e74-d81d-405c-bad0-c97ec1aa=
4b77@linaro.org/=0A=
=0A=
> Probably needs a review of which values in each device might be shared=0A=
> between perf mode and sysfs mode when they shouldn't be, as there was=0A=
> one in the link above.=0A=
=0A=
> I thought the only thing shared between sysfs and perf should be the=0A=
> 'mode' which is taken with a compare and swap without locking anyway.=0A=
=0A=
I think it seems bit of hard while sysfs exports interface to modify config=
uration.=0A=
Think about one source enabling via "PERF" and other process try to call re=
set via "SYSFS"=0A=
wihtout locking enabled "PERF" event can have different configuration =0A=
because "SYSFS" can change the configuration while applying "PERF" configur=
ation configured by perf event.=0A=
=0A=
(CPU0 - enabling some coresight device with PERF and configuration from per=
f-event=0A=
 CPU1 - reset configuration via "SYSFS")=0A=
=0A=
I think it seems hard to shared only "mode" between PERF and SYSFS mode.=0A=
=0A=
Suppose one soure device's mode is DISABLED, and=0A=
    - one process setting the configuration via SYSFS interface=0A=
    - one process enabling source device via PERF according to configuratio=
n saved in perf_event.=0A=
=0A=
wihtout locking, how to prevent "SYSFS"'s change of configuration while it =
saw "DISABLED state"?=0A=
I think wihtout lock, It falls to enabled perf event with inconsistent conf=
iguration.=0A=
=0A=
IMHO, only shared cannot be mode unless sysfs provides interface to config =
something=0A=
which can affects function of hardware.....=0A=
=0A=
Thanks.=0A=
=0A=
=0A=
  =0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
