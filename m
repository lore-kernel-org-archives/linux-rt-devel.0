Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B21A8419
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691126; cv=fail; b=j5t/435BOeeZ6OETQM43Icwig5cw2yZFrb82nCTicd3zDdWP9OkpVIeJLLR1trOXTTWJwL+wTYKrCXf8+XyJbn7ohroKxxE6i9Lo1sbxcjJbNpKYRaah6kTKipooUJswzLqUW2HPx1pXLlnJbNVscTVfO1iXKJ1Vx+KR2p6P9TQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691126; c=relaxed/simple;
	bh=IGEg0DHmPAaOkT2r9tTsw9TgZ82FrQRzJ4lSzrF/7nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b4Bjqt5sMNkOdqTycA8oMnEiU8zlnogn8UcfdVV6NZUkRdTRgnjLFmBPH+FUPzPiRGB5KuQxf4UBpbkRAz32QylnkUaiUb9zuGSUR+Z6FX01tl9isI+GtzNgoHLA4nP6yQjX8v1H9+rnZXzB5XCauUKaz5wihAXojBhAhe96T5Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZaLWaSVX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZaLWaSVX; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZaLWaSVX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZaLWaSVX"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Iy4Z0owaV3BCjdgdrbLS3QMl0U/XXtpNk6pDjrQZKLOnlz7umEcUYzltwnhuDhnWvmQinYqiQr3H/zpyZZSxR307xmgeHOqZlYMKHn8Tswn/aPxtMp0VuuYOUC2CAU0BlHY6AknEQtPAMNcY4oIFPOVZyinCmOp4rCANDl2YenPPbo/pAwHZ0PssvoLQCtVn/rw9CSEuFI4hUT/s46/BivzEhz4KRC7+jmfYiMCTYRjYb7CJLh0H3lI33YfqB84NZLxEYqNDdvzePCuqBpGTyho8U9FTuKhvE02cZ9SN3k3bEhb5kKaXXcp/bfSuTu6Vi1m6NVV6lVgkzbCytgjh3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGEg0DHmPAaOkT2r9tTsw9TgZ82FrQRzJ4lSzrF/7nI=;
 b=Vn+UO8toyJLU+hBydUDm3rZtm2N+3/pWgwfJeA4WZVvI1wvFd16HvEmJV3lPAttQSr48wfUUtQzX+fSv+n6hi51FU8gMQzJSMg2CPAptUA9al8Eh+AroxbAZG6NR4xo7g4GQ3sWkRuWhV2O2UUx2aTd+bb+RdbVJtsJt6/yKFZFirLdZ1N8RyxVunPRQzaNliH6fgFRXQoNXvbrXwHGe3v/YKRKjJ9Gt0sis735PG0/GVOUM1SKd8idIOCcWSfLI6Pg14i/guF3fVqcgVBSesgzK5gpb/tBl+4VQZHd2UOGlf4o/zbKrHINe4KeWh4Cpk0TjyA+Z+H37Burln6MaNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGEg0DHmPAaOkT2r9tTsw9TgZ82FrQRzJ4lSzrF/7nI=;
 b=ZaLWaSVXmppulisEcxxZfM5mnzzQ0jRvsPB7JotL16kWvxZqYwCyjn9LjG3mWKlZLpllbRFsdUsknroJtNSbdF30OH2sD+1SBozr6fa3lBdXxab9QHXN4XvEIP3Z3f5dR2yqdE4RcQx+MJjaZkD8RBtpfxxhVlzKF7nUTMUNP8I=
Received: from DBBPR09CA0013.eurprd09.prod.outlook.com (2603:10a6:10:c0::25)
 by DB9PR08MB7796.eurprd08.prod.outlook.com (2603:10a6:10:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 10:38:38 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:c0:cafe::32) by DBBPR09CA0013.outlook.office365.com
 (2603:10a6:10:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 10:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 10:38:38 +0000
Received: ("Tessian outbound 8c86f99b1b13:v528"); Fri, 20 Dec 2024 10:38:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 293dd6c4f1467221
X-TessianGatewayMetadata: 3fk0UJQ9BpOOLy2C5BNCmsZcQSqZ83/RI9Zx79RxREsjHXMiF5PSohBr3duGY51SyMler9p+QlcCNJmwUEE7pQ9Sr2I5c94V6SZJl4s2kKJIPl0wptdLTlXw6Q/rkHGVQtM1ROuTQu9GZftozJQg6g==
X-CR-MTA-TID: 64aa7808
Received: from L238d6f546fb2.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2BD85428-0954-42D9-B560-CCA40A59207E.1;
	Fri, 20 Dec 2024 10:38:30 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L238d6f546fb2.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 10:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNcDl7/E44JyN7CmGWzx/oFgrIc+pD2Ko3/VsaDiORnlteDckGE+Yg1y6vaOTT4wUOvhykphpRVE4z7FMliYIMNKvWYKSqxdAOqmlhwYZz8rqhrFw3RjYIMxmemnGaBpoK5IrUsvZD1AOK6OnG8UL9EO1ckjtc+7uMeQ115q5OPeBNx4vl+cdpAOXUCycHz2oyVN2hugyRSXBSRH6VLABSQRtlMRyMge1rgI4g/3haTJ/lYkie4QLPv8r54jVqtTZ2lQiK0RgOWGMVq8EtxalQyKlh83MYxLzJ7medsJyygAWFPGofoRvgL1cHLatUfgoSLRkmnbtuy1ZdkylLNIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGEg0DHmPAaOkT2r9tTsw9TgZ82FrQRzJ4lSzrF/7nI=;
 b=ZPNjWorxKSIRZ3sCZo0AVIbzyNsLtzkgU5qzx/0KRjc/UqgBWmCAsiU+qilj6nAD2tJW4KCrkagstBzq/Y9gS5yLE6fR6EwfcUVoXDxztD2VDmUCPNTwzC83uuchYJ+7bILTXV8LAvgd9rOal3aGk8lIH0f6r5CxhI5b1CX/tx2xK1fXNLNpd+wPCvvXRf0c19dsb3aC8U25fofphY1jN7VpWkuy84nClVPuQCVgIPcVxYNmyLDaCU75fc5YvqYP6NhBKTaRDNpzXbYLr4+iwoopEMILOpy4fvNb+SVBSe2bYE6m9LWIjIfH9HnsfBSHbckncnbdtJp+sO5JqwUevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGEg0DHmPAaOkT2r9tTsw9TgZ82FrQRzJ4lSzrF/7nI=;
 b=ZaLWaSVXmppulisEcxxZfM5mnzzQ0jRvsPB7JotL16kWvxZqYwCyjn9LjG3mWKlZLpllbRFsdUsknroJtNSbdF30OH2sD+1SBozr6fa3lBdXxab9QHXN4XvEIP3Z3f5dR2yqdE4RcQx+MJjaZkD8RBtpfxxhVlzKF7nUTMUNP8I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB9670.eurprd08.prod.outlook.com
 (2603:10a6:20b:616::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 10:38:29 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 10:38:29 +0000
Date: Fri, 20 Dec 2024 10:38:26 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Message-ID: <Z2VJIh2+Z40bZi1e@e129823.arm.com>
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
 <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB9670:EE_|DB5PEPF00014B93:EE_|DB9PR08MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bc1bdf-46fc-4f2e-68c1-08dd20e27692
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Ilw3sHwLzit/55BN1iBINibWpm7QSUDVsyT2x0fOnk9K/2Gb+g+zKb6268jP?=
 =?us-ascii?Q?DssO2hfDRqd6HWDMwCcwIMzPpJr84qYPlhBWBzlYuY49M1hS5uvywTwYixcK?=
 =?us-ascii?Q?g7Rg4nmYQcK1j3bxO0BnBcYTnS2JRdomW3OeIzL5t+zi15+9i3UcgXF8urAm?=
 =?us-ascii?Q?9QYoOowC+JYJ7nyFdNsapvJk2ZhuIA3LdfIWhzd5llQ/ghkr4dV4NvZCk/xb?=
 =?us-ascii?Q?eAzlv1D1cc3AmtJF/b2bjQQGkzTVIhopsijaFQnB4ScJcBcH2h8t3yQeJVvk?=
 =?us-ascii?Q?SImiPIQSL2//wbioJh/zcu5Bxqizx0+iUW8jjuDh9I5O1DwWMAx5hXY/p191?=
 =?us-ascii?Q?di+f39XBlbE5Ezawr+wam9k+F8ffaM4SeylLdc0+MvzaH6zTlEyTIFNcrprN?=
 =?us-ascii?Q?hgP+n7m8xS8SF5lUEvYpwJ5w9Wb3yFW7iM1Vh7HBBhYjomABcBJvRclWGOVV?=
 =?us-ascii?Q?BniMCc4YaT0nhOl8OqgxULXwRKXjg597eGJlewqH5sjc0S6KhGvXM47chzXE?=
 =?us-ascii?Q?hwsL/DT3f5XrRe4Q99vjyTqg7DDU1fxz6EfL/TsbrGJo7LQ0ylFZVqn8x86u?=
 =?us-ascii?Q?UJXhRqu/Tq21Kfe8fkdvByP94T39YFjOgDXpg+DOWcA+4CEx6WkN6IOC8ux2?=
 =?us-ascii?Q?Qj4wpvfWn+hgO58faySeD3xHyD2gYKfp0ox6UosT9bX69MTP0g8otkmkHUX2?=
 =?us-ascii?Q?nz6mJNynoTbuadQUaOj15/IPD5xFJgpeRMtpRil7O5arEFj8L4eReokjl6u0?=
 =?us-ascii?Q?i46L2e+1pEtPHnaB6kN0OVSZFiW5QirZM1gIZLfiPXSZBOzAgIyczBcJVsXD?=
 =?us-ascii?Q?p8ePTNaKeXFO04Vdlj/0MsAf9I6UbFGlpDnzmsnc7c9CPLT7WimGWewTmU2M?=
 =?us-ascii?Q?jSzo3RNMbRhW6Di78bESo18UoY1RBdUtjm95bL3KBRNaC0H6O9EG8nu5ae5p?=
 =?us-ascii?Q?6TAE6Z29luHFasWPb2SjBqKDRMxCniXhCv7HRmXZbAfSz5RQ3snbJNhrzheC?=
 =?us-ascii?Q?/EETxJaBdVGyHtVVVktYKLkA2Y+WP9hBPnQcbPAcCth2lPEe/1SqkTVoELSr?=
 =?us-ascii?Q?nZ2j9SZglmFDlKgSb0EF796P+nKAQAZbFHq6bLMdC7nzxB0Ic8vt7VPImkef?=
 =?us-ascii?Q?EgJJXTHbOpuncFMS6PG7R9va5k8SevsBlk+snutUMZtl6/WSt9O5elLj7YwO?=
 =?us-ascii?Q?mfSjcfURI6RxxtBaEWdu9K4i3Zm3kkcLzqqQawbZ40x6D8rjEPqsUdIfmTCP?=
 =?us-ascii?Q?7ZSRI2YqN08Rvaw7rF53PZwf6kTF0JruCv2rruByq6/DWO7cRuGqJxbuw/F5?=
 =?us-ascii?Q?lW07FEZS1IEff6Lpx1+6CbG7O4YEjHlCuGd/unO+b0I64BjAw5/+IwQ9A4SH?=
 =?us-ascii?Q?gPleG3GIAhsvuGhhcVQj5CffWlHW?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9670
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bf5bc016-cbb6-4836-d73a-08dd20e27136
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UuNUDQ+E73VmJG4SfkhDqaZmYyNKJY4Kd/aTkN1lclH7a5WaEXJhjHKOh45Z?=
 =?us-ascii?Q?iGCRiKKGhjoZzGVUA7h1O6Ast81EdIwj6GmIgANuBJ0quBe90lf+mH2bAt16?=
 =?us-ascii?Q?rP+u1V1tM2Ghomcy3cy5KPbATg89jiOO49s7o4XAiE+bsYsthyrTK3oIHrTr?=
 =?us-ascii?Q?8BdB1SCX8R5SzaAU6IKjUudbMmnKJawxXvdTTsMVUWEuUHX1OPyBUywdCPDE?=
 =?us-ascii?Q?hqUcOTBcbHknRDR0ZM9uknDcEhxnaAZOzLFb/S2ErNrVXmKB4aVfPk4PRcDv?=
 =?us-ascii?Q?/sfmRv69eh7rSZTJ0alxyhAyotwybJ4blMK1Z9kCsQXIa3NEqSIaRUTdDyXt?=
 =?us-ascii?Q?CAnZdCSXXEFWSeKsHXnWunPE3BjGhXL9AHVRQ0IEfxS9nUms3VsAs5pP6ES6?=
 =?us-ascii?Q?aCeeukiPL/3bUVpFBfU4e3HyCQFOd/zNg2VhF1rNoZYSjaWecKHhZwnjBkYf?=
 =?us-ascii?Q?YMSn8dLTiJwQPARkEmUv3VM0fS7fzWMWOgnD2/5nVcu6CVtjUL1DGRSEwhau?=
 =?us-ascii?Q?vecp7I/3LWJPkhPsi9gW1rShaP8QTHSxy131Vbi+joiI+XV4Sjme3EBdOq32?=
 =?us-ascii?Q?wdJ/LlBN0uQsQ55z76lSo59lZmhYu5OzOzlloQDFjUdOEBR5qGAVBGUPIhWk?=
 =?us-ascii?Q?dn1ne8xpeMFP7gVpQ6HDcCuNhLw0cHoSbYbcahmU8YDn080CtVKUGU4kQ/Q6?=
 =?us-ascii?Q?xe+CPOXgYkdj4V6fxL5P93XrhOZpeb7RaMOI7nlExUjxVkuN7zI9nawAXKH7?=
 =?us-ascii?Q?CFanRRbgMpZ0bjbAqyW3QqxBT/Ek4eepX386j75V8BpeRRyg5Y+L95maG/YF?=
 =?us-ascii?Q?RCKwpZlz3D45gP27SuPKft+/Ezr2PuIZyEftFqMeZ3xMWcfs4dyQlpJ9adyn?=
 =?us-ascii?Q?a+wAyGdUTpgVtZi9gwnu3XIgRrTTKpyPmNaDtlJ7gLfCcN6SbH4y+FzGUXvt?=
 =?us-ascii?Q?lul8SAylhmAMQIot4HHSefg5vuO9ObMYmOmcGjAn/2w1Qi97fEE79nYmFiKT?=
 =?us-ascii?Q?u5NcxfYoigeKl7eTLya2+47dyF82CxEv8JAsd625pvwXTze/DXrfEzU/1dux?=
 =?us-ascii?Q?EYf10KNdYoTygxnT50CS7EDH6YD9Tsz/hzNMheqlW2CcihLhHZMVSZrAZAim?=
 =?us-ascii?Q?d+MI7z7T3BskT7449/n9tGxpXLRQaLeeaDuTTOUenhY8NCZkYLJSEyTsKOvo?=
 =?us-ascii?Q?NzQnvT2RS98yKpOKLitWD7ryObzKdDyXKOc7qUZbVzb467nfJQIHpREtMi8o?=
 =?us-ascii?Q?3J1E8fd/HriuLMyRvQ+0brE0AfwiLnJo5RZZBKwYyE3LlTpSEOx8PY0eKD7R?=
 =?us-ascii?Q?No7Tb9EfLikSZLj7b4LJlJxWHJUVeBMJNHFnihr+oxjyXoevbNycaxMFvSO9?=
 =?us-ascii?Q?yEZbcGNdoBc55uFrwu9kwqtd0esJ5rRjX0awCwiDYFNEEUeZJwUkNZ8zWRZY?=
 =?us-ascii?Q?pMQfm7xXOa7pskJn7T676DTJZRU7IXUhcCzS540LOrymcaXnTiyZRLocMKrB?=
 =?us-ascii?Q?6olvGuCXTKMVxW4=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 10:38:38.0326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bc1bdf-46fc-4f2e-68c1-08dd20e27692
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7796

Hi Mike.

> Notably missing is the same changes for the etm3x driver. The ETMv3.x
> and PTM1.x are supported by this driver, and these trace source
> variants are also supported in perf in the cs_etm.c code.

But I wonder etmv3 needs to change. Because its spinlock is used only
via sysfs enable/disable path.
So, I think it doesn't need to change the lock type.

> STM is also missing, though this is not directly enabled via perf -
> but could perhaps run concurrently as it can be a target output for
> ftrace.

Actually, I couldn't find out the path where
the STM's lock could be grabbed under other raw_spin_lock (including csdev)
If you don't mind would you let me the code path please?

Thanks
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
