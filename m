Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A51D435F
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Dec 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214738; cv=fail; b=tpYqyKds2w/mE5Ak0+A2M3cUhxN9Ta6s7HiVVNWmJijMunBNXiX72y2lElb4BJ4E+4V27j/2iRhCpp8CJmEE3HzKFrbvXEOJbyNnfHvzk4WHO7ZHvDYbUBnCbwRbu+e7dJACBmGTHHZ6UCjoZTrHjXhiMHQJteSFQAQoP1IMlx0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214738; c=relaxed/simple;
	bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNT44c4w6/K94NmSROvE+rmMJNHxEyAdOZ04Y0hH/rrL5/+eNzsIXO7djDcmYrBb17apVh9Sdu0F+54aa5AFYh5XDuGVUSi6Ie6PJq5QeM8r1ye74iTikONuhFcOWVVjPmVkKd9zEF8pdUOpcTexGIIOdg40AeOjRwWncEYGpgc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p/e5Qn7q; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p/e5Qn7q; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p/e5Qn7q";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p/e5Qn7q"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vcqrIDOq37H4khjivjrxIGZEuWQM/2HrsKJ0V0A6vPOGuk1zmErH4UxE8IA3dq1qvlECv3JSnWnqLkqHc1fDuX+4kj2ASgg4w7iDdHjFZWjXSZiSgUXzUNwKaIdll9GKqznYo9urCGD1om9gGGhYnrMRwYVreKWcJ8nmtfZQUJxB9dhpBUyKndm/S7RC+KhSWKY0XF15nBf0BqAIydSbSKuxy4qY3z/qDYy9I2kCMAYYujDEPt/vOxNXE0W7eYOGkCJzfQVe9a/2zxoXeO1f+mEgA4gfuEpidxDG5T5xzmFHtMTR8tANFlv2QOdZK6Fwp2eJjjOFMjIlO6G1pS8Msg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
 b=Y9O9NL4/syvOcw1WpkmvykKs42qqM9gq4yLvqHXOMgWUCbN2Y/frgjGWuW3/Cur2yV+CWAxSBE6zF1IuUppfgPRgteojf7f5qbDgj0qGICGdJytukyUVyinzf8BTl2UE8go6U1Up6S9nP7EFcUH1e3e46ePXl2GkwceKZwrmg4CJD8v+QCu0WdAYu0z1PBPrGzyi/QHeM4IcxEeqWVQPuZD3HXWzc1wnRMtQWN6oukZfTHkRnnwrC3yy4xxUB5JiokNzVMsXBzT9AkJX2V2LtY87vZS3Bms6/NianjKzmFymfiqu9Gp15gCCHVAb+JOXMCsowar/9nPJeMDepvXeLQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
 b=p/e5Qn7q8ZDKF9+XngsrqC7fQgGL5KW0GP8qfjN0s9eYqNq6M4bbjJSkuJcf2ER3WcYezZ+zwQq/bd91bEkQIjT6Iw2mfCO4W5mMXltIVc5+UfYh+J8SceaO/4lmezRvNgZXhkowOBoF9szUoh5vFoqfhQQiF+MRu66AC5Q/HPg=
Received: from DU7P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::15)
 by DBBPR08MB10589.eurprd08.prod.outlook.com (2603:10a6:10:538::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 08:32:09 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::2d) by DU7P195CA0001.outlook.office365.com
 (2603:10a6:10:54d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 08:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via
 Frontend Transport; Tue, 3 Dec 2024 08:32:09 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Tue, 03 Dec 2024 08:32:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 63d13b2edf158995
X-TessianGatewayMetadata: 6idn/wc1W5aPcQPxdEUmG7UKUYesjo3IgxIozACPB+rSudKWn4JLdzOxLeeQSN1qZgOzHKF83oAZmv+0jUCl6gTnrVre88T47QYzSMquvgkZFTp9Cfe4fIxPLO37KcR/GvD/nP2ZH6sm2HjYHuRz/UULgF+Qao0puW3FpvHmShM/BclFHYH/TANbjsiEngQXsvZrwZgIBPaT2vybvqxvFA==
X-CR-MTA-TID: 64aa7808
Received: from Lf171e610a83f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 43CEDD84-68D3-4C8D-92C1-4940468DFC96.1;
	Tue, 03 Dec 2024 08:31:57 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf171e610a83f.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 03 Dec 2024 08:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peoCTb3KHXFxbfhLFaaf+0Yamh0tl8nu9DvJPrp8u7X8LwJG9Jk8eWnWMFR+11yMxu0pmnZRLYjoBtgwa1lF47qMRRKqv5TUXzL+80TQb1rEFORLuzHIkodX3z8qYhW1STjhnHSvZc0veVG3DyYi3uNSOQN6A6tNamOKMscZl9Fs7y5a9Ka13ezGr9epcnEZAeRhQX1kcEQnDy1hkMURHwADtSsQetYM/cvXg6SZO9xRtjYTq+MFXV2Lizlwz/lQ2UgMUJn9xJQ2RiL8ERWMEGMH2OTwOopjOUz3hAH1lJzdgZOExloWAAEx8l0eStbjM9kB3fWKBeVWW3UEriJRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
 b=gV70LC+byJc4XWuLkgKByjnC7sMEJYTQeP/nv92akaYhXK0OB/+ve2lqYVHL4At4iLtycY+BMByZT5fci3LtWhpXNyfz9w/DUfDvIOc6kwVGw/mTPSzKki8sCmubetwGehlO1yPn9N71Ium7KH9Z3wY5DQDKnnjXH7MrXcwejkyNzsOs4X/0mKdIVf6nrQYvqcqJXVBbU4OwIkr/Cfwe5kWAy0TEhx2mZTpPbmc4hUyPOGDZzzYMeJCiwQ76/vmtuMsW8L/aGvaSBBqo8gv+sxPTfXrzgIQ90EZS10jZy4/knCNjvXY9mToSX0A6j6GrdMX1H7Mfh6skwU7dOouA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ovzw4oVBxKJdsVrMXlBe6NPWdDKNTyRgcuLxZrCYR0=;
 b=p/e5Qn7q8ZDKF9+XngsrqC7fQgGL5KW0GP8qfjN0s9eYqNq6M4bbjJSkuJcf2ER3WcYezZ+zwQq/bd91bEkQIjT6Iw2mfCO4W5mMXltIVc5+UfYh+J8SceaO/4lmezRvNgZXhkowOBoF9szUoh5vFoqfhQQiF+MRu66AC5Q/HPg=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB3PR08MB8795.eurprd08.prod.outlook.com
 (2603:10a6:10:432::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 08:31:55 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:31:54 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Suzuki Poulose <Suzuki.Poulose@arm.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>
Subject: Re: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Thread-Topic: [PATCH 1/9] coresight: change coresight_device lock type to
 raw_spinlock_t
Thread-Index: AQHbPx8vuTignQOEcE2iGTau3pde/LLLYBwAgADpbc6ABtjNgIABGYcA
Date: Tue, 3 Dec 2024 08:31:54 +0000
Message-ID:
 <GV1PR08MB105212FEF9251CA2B3AAF7FFFFB362@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
	<20241127120954.0facd34f@gandalf.local.home>
	<GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <20241202103853.26db0c13@gandalf.local.home>
In-Reply-To: <20241202103853.26db0c13@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|DB3PR08MB8795:EE_|DU6PEPF00009523:EE_|DBBPR08MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b488851-404a-491a-d819-08dd1374fa56
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?BMPQdsEu/sZ8SHA8VamLxwJfxC/Dhk8spbMAdE0AuGtONMADs/DjcZFzfk?=
 =?iso-8859-1?Q?xaZ1ZJXgq544uId+Ye4mZoMatEo2IccDSZ6mm66hiexBPaDvqykRHqwkSS?=
 =?iso-8859-1?Q?WLM8HfccNPvWxanYv0c01mbaGgCHzpIGv25bZ2nm37LQPezprI7DHpnIuV?=
 =?iso-8859-1?Q?s3wmUExlOQOkEG3b4ovpSDglziFy0Pm6pd4WGE9uVXbLXDzDIdZxAp0eHA?=
 =?iso-8859-1?Q?nwIoXBukYBnubHszXsUV01FU+WzgH3GIJHzp0RObVaBpuLkWYKu3KafhT6?=
 =?iso-8859-1?Q?74zIAS71Ttz5CR8jafzStrwXP/zat5A5gkKUYNSOCchS2qEIDmxmI+75/1?=
 =?iso-8859-1?Q?W3mIuDU4wxx6vMpwN3OM5D8aFcDF9K18MGgP/hNyBFPhuaAef8NBwgmEX4?=
 =?iso-8859-1?Q?KsCMxT0pwznp/yEDUkkhRGinHN0XqkC0JvOSydZwBnIyzFBqrpoKWud+bd?=
 =?iso-8859-1?Q?FQLDV5fwWV0FPDACYSMsp6Hs0AUUpSEpVDDqCQ1wnVY3+AYDqnl8SIIZDH?=
 =?iso-8859-1?Q?NJOEk/05Adc54/QbDV3hbPydKVKO1B6CHY7N6Ucg5X9z/yXJ6L7ToU7CQb?=
 =?iso-8859-1?Q?c4+ug1QKhWTG/xXbHfQYCGQrTzP4tor04hsRPEF2lX9YuObIbPqX+RKrzx?=
 =?iso-8859-1?Q?J3LGvRABipI/RTMosGMVZQs8BAH4t7k0zoEHiRgmzOHoYJewJYrAlbX79g?=
 =?iso-8859-1?Q?QBi/g9GwobiUAsC8LdHmbcW0BZAVQ1Ly0iqN9ooVHW1we/bB1+7I3FGSGI?=
 =?iso-8859-1?Q?V6VFiH+8lBqDzhGexU7sB1dETGQx2wJv1R9jcFkasHEZi2k5Lo2k8G9C2H?=
 =?iso-8859-1?Q?m1MnDSlR7Qu7+2ZSmCMUE+VBdPrqPmEVJZPu9lJcB3efivvRyROTyP0dcR?=
 =?iso-8859-1?Q?bKZJbZ4UJy8zcFCVUzXtCU3YdI0OGOPQZ3rUTWi3m+GmPR20bSkktk0Fpa?=
 =?iso-8859-1?Q?+A9bTYyQAW81qymNbtJGppQNl2Vf+Gr9oor9WPMqV2GixAf9yGIGP3uhOv?=
 =?iso-8859-1?Q?5DcVnuLSDE+bjkn/UQQICJ8vIOVX4C/l48ddd2CpGy4tpzQMrn0dSYQRJR?=
 =?iso-8859-1?Q?e+Kva36VWo5rJ2gy36VJp2ot4A+V5DuWbn39VuITdoK3uJ9kSRonu8TxPm?=
 =?iso-8859-1?Q?S2fsA2x6R5JHEjkRMdHWg4vaOe55sE5E70vnYIr0Ktio9DywYSYSm5yLgF?=
 =?iso-8859-1?Q?tR66JEo7ibARb/1VDZyKhT2KT4m+vzH+R55AP9fq7NxEuQKBW6or3uY5f0?=
 =?iso-8859-1?Q?6PZkKMDKouGTZDrGLyfLF2T1Kd7wgoJVLDr47AvPZwIJsCtvXEt2qTR7gL?=
 =?iso-8859-1?Q?M0br9lVjS8GPWmnH+2vkXCkafMtO9ZKaWYD1m+TA4vTQCylNu74c6MuUiD?=
 =?iso-8859-1?Q?0+3if/RHQHz6YABhzo0901g2RDTPiCsXuB+CrDQ1Vrr/D9jOkoSXRrrdpX?=
 =?iso-8859-1?Q?QszNhjPbottkhjhyoFUjlaV4jSH61ALUJuXYqw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8795
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7b1c7170-b885-4190-890d-08dd1374f18a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|35042699022|36860700013|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?5e3EhIRDOPPW7soESD7ph4tAAlbfjlj/FlNj1xRkMt4BVNRs3DBccRJ4P2?=
 =?iso-8859-1?Q?0ec9HfT+Df2MeF50pO1KxgMGCDMZelfW43Aicd4X1+BPxQ8Pri0fVWObla?=
 =?iso-8859-1?Q?WXrng3mFXOGR1wEpMG1ppiBeL6gk/qeRLA8N1L9xwv9+9tG0gXUltJbQLw?=
 =?iso-8859-1?Q?8+y7i1vV0/7JtE1HGXMFMKveUv+RGThD8A2d0hehp1TUcw/YMRSJzJDNWM?=
 =?iso-8859-1?Q?/BNcnuNLYO4VGFt3Ztg1/3lYO9T9RHzhIdaMCqkwg/ZEZ8FP7DG2gStSYc?=
 =?iso-8859-1?Q?A5JooZNW/hHyEJUkDO0wSFerM+oQLz1C2KIuuu+8Y9F8uoFCPbtfs+OXUD?=
 =?iso-8859-1?Q?GoC1jrdzESGq6bCHzXxLLhi2ARmZQ23vFkzqfE9bG16Ff/P1dcMIOOmKHR?=
 =?iso-8859-1?Q?mfT/KilAb0QBhS1biwQGp6/epPlIJleyKjjEgvSnBHDCpvKFNn9K4OowKV?=
 =?iso-8859-1?Q?V/UBnLxV6h/oKNQQoUsQwGaU70X+bW/C6W0Km3uadsBxYgQgI+UPbdkbvR?=
 =?iso-8859-1?Q?SVO98hMqhAvrgV062wFfFssAOwkDOnE4PQlsS62+bcu/uJkhuSfLaQ43ub?=
 =?iso-8859-1?Q?DSWP7XXL2JeBPte1ONTdTCqcyi0y8XGsdGzomUMil9PwLZfYCHQF8w/lY4?=
 =?iso-8859-1?Q?dQ1d6riJlNNS6oj/bCjiAHp84IyHb8whlhIQUVSdc2uldytpFYKxJl22RY?=
 =?iso-8859-1?Q?7VW6Nt9Puznvo0WlgtNTjssKeDeT5pkP/FuuXY1a4clD4uoRIXLIMZyQlo?=
 =?iso-8859-1?Q?qfydH0fB8f2bC/Qr5HdRnxitYidBnKdFV0oQq+eJjHo27DbqUdBHPGU4NU?=
 =?iso-8859-1?Q?c5fCHs8Prqz3/eCk8WtDeha1twP4wopDbLeTIbqEhtEaXYwMfSpm4STOXa?=
 =?iso-8859-1?Q?+nlefBOS2R0w1G0b6BahhCGW+kakuUuM/EnpIe+XOYXFV7pJUhy1j6tMvt?=
 =?iso-8859-1?Q?bb1/vNLnNJA7ng/0C1Ntaz821UNpumF+125/LOpnq8lCU9V/OhMB3MpOHh?=
 =?iso-8859-1?Q?NgfrE/IX6c3tydaSf6N0y/IQ5fb7R8V9rC56LHy2n3EmFte9Jr63K3Q0wc?=
 =?iso-8859-1?Q?MXJ0HyKBcLfrrCjfzjLDJgZEFVfUS2uYoGCRjNHwKyhYvFtMYo7JKDX4Xa?=
 =?iso-8859-1?Q?DGulz2qTsMYveEPdZi667qLsopntJRSaQ/oYBtBRtGKifN0R8UXO9J1oCg?=
 =?iso-8859-1?Q?fyz09FqmczEJ9D1s7bnoLGD/Amhiyo1XDpMARwWnERnipnNFJDcGDjipTM?=
 =?iso-8859-1?Q?xkLySji8EpIb3/tQVT0844onMUJlA06faFAbf1alWdgwRetClM6u2Wem9B?=
 =?iso-8859-1?Q?GQbcefyeTAdc3IFKl6H4VAj21/qF+wz20HVdzWgzQ0eR++qd+S+6w60Jz3?=
 =?iso-8859-1?Q?nBxWqp2ylcgd8naOPjr5jQP6+sshIuhwU/2iI07VYTpBQuFLxHVMRu2hUG?=
 =?iso-8859-1?Q?rED/z+tydQShCm6VQ6VnQp3AbBsFHR0hNdaizBFrM4fQy6pv/NkPHGqFT4?=
 =?iso-8859-1?Q?XnGRWsLErMZD+wY6QjBpZj?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(35042699022)(36860700013)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:32:09.3607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b488851-404a-491a-d819-08dd1374fa56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10589

Hi Steve,=0A=
=0A=
> Still should be documented somewhere. It should describe the maximum numb=
er=0A=
> of feats that will ever be loaded. If there's a max, it makes it back to=
=0A=
> O(1). With a 'k' of how long it takes to process the max number of feats.=
=0A=
=0A=
But with other patchset seems better=0A=
since not only this function, but also for other functions too.=0A=
=0A=
BTW, is there any example describing this I can refer? =0A=
=0A=
Thanks=
