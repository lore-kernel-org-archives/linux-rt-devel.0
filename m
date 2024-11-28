Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296BD146A71
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 Nov 2024 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779589; cv=fail; b=sXwyJDjNPpMPGnvC3RP4d0DRDO8mY0Gz3/0iwGClXoBPJBH6eR1NkB1kUFr97jbqK2TaM8E4eEnIKoCHlZA9ixT+x0smpM6flp4MO2EJj+oasZBbK9dvzo0zZxMUQm9HLj47z5Bcoieq7XM3vOCcMCQ8IysbxDbW8r09TNcRGKE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779589; c=relaxed/simple;
	bh=sZjF0TXA1r/BNENIdwheraPYna+g+Pgl5SUbbgRsUwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9TiFJyaWQZvNVZ7ygbOEupFbyC7/3mB2Zbnna+neVgTSKFKwWPvjcLEGNDTRT+7wgifHNK/w+WNgR3g9KHdfBpSoV9cbkHR0ULadD9gxYVqlE25idzX74v0B+Z8AZJoVqgZx0um+saoye29RJ3icqtF97D4c7jtTcOHBB+akww=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y//h4KPT; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y//h4KPT; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y//h4KPT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y//h4KPT"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vnpX3CPb0JVBjZAgx7AiEgTX5k1lRlFNORfBdl+H1iE5o7ozssEZpssgqCq5V/uKP45Ldp/UleEbQ0ZIoFg6tR1Jx9FGFcwsWjYZEW/L7UeBENPWdLLitFMQWdqPpR9iYo4QtaAQN8uUE6bjbNNYIsO8wAnSefLKeAzRomGsRVIART5Q9qWXNW/J4hN+r8CmA/c5kQI2L8Byd+RzneEzHyb4kg2ONJv1j9qUO8dzweGP3b114+8n3Sjz6OdUxuy4ncK84v4VM9cYNVBvGJDdIJdLVxPw2EMzp4k1FRSnNWHMkObR0rLXfIu3N7OY+gRULHHf/4lvr5Bwxg7l4kkcuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/tpeceYyYHj0O55HsKb0pEgU6wm0e653aMoxVz0HYc=;
 b=bZmb55RQbKvYq+49ePoZ4DMWO60nOckasFLOWMPreKu8QIiidpIlaJBwfh5+6/0+fRUsvT+yd37qZ800uWdsEFb2S44HKhjkNqoJPAC+KgOgFcUo/OnnNgMo9A8Hw0K3VZCwPtFv4hB9ELSaQ20kd4W9VIp5h9INRSyfhsxsFYu1jNWM2GwZixhY6ppRApdwW9jmr0S7THnHEAYdiCdIQsQY559k/LY7KauTylrX9FZMxENjX2x5cD00cbU5DfaX0Y8dmPELhdu5/ARkdXS+OQZnqoLOwnVjKxehr7K/llf4E8qVVSvWpvtkWEgVrG9s1pEQSv9qIb6ROB92UrsSRQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/tpeceYyYHj0O55HsKb0pEgU6wm0e653aMoxVz0HYc=;
 b=Y//h4KPTKqYGbO0Z3jPqpdy8DEGaGVX6OHAY+ywYqvuu5THC1BemrOM95D+NkLQNSPjdv17icqywhAO9pGxc5MhEe6jEQANp9qiumJvC+SILrLkv/oYWYI0VNMRHjcm4DIMAs9+I+Z4KC2nYkFBUoTBMzQp/ajuVHetUYHG63wc=
Received: from AM8P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::6)
 by AS8PR08MB8062.eurprd08.prod.outlook.com (2603:10a6:20b:54b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 07:39:41 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::8c) by AM8P191CA0001.outlook.office365.com
 (2603:10a6:20b:21a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Thu,
 28 Nov 2024 07:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Thu, 28 Nov 2024 07:39:39 +0000
Received: ("Tessian outbound 206fab1c37e0:v514"); Thu, 28 Nov 2024 07:39:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 21a83b3e99bd773f
X-TessianGatewayMetadata: 9uG6KGrLTr25Wepjcigbts01uv/ZZHjcm5OenUyd/jiZNAa9dR7OzSLSyXG2O43/c0skvTdyKTJIwEAQyqyj5er0LdAmGbu18emnIX9FLRdINp+65OO0vgm9IzALO2Vsxz/NnlgQkXWBnJIcOfT/wSFlxpZSFanZMizJUnhFYQNRqLgvOMpFn/tvi5bJ6kVXGR+iQAUFGCohPF+Ic+hXlQ==
X-CR-MTA-TID: 64aa7808
Received: from L75f4656fc1b4.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 639224FC-C806-4482-9B48-2365545EA815.1;
	Thu, 28 Nov 2024 07:39:28 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L75f4656fc1b4.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 28 Nov 2024 07:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1jAqv3IQOYTC7l0RWfEaLHZwb8Z3f+Cy07uW9buhDZ4O5ITvPGxO3S6Z51HKOTP96H0Zsazf788zfk7PgWid+AiUtd9MYxPssfMqpvNJoqWNF6VN7x44b1hjjvx/IKltXlwZumY5/wsWU7i3zmL2EdKQWxTjJARzOcKHY5ISUqgpaPPFOUAvqeTe847AFRy2Fxj8RyUYbgN0oycWoV36VTlf4qUOxXdjD5RBzy+SN5ykghnzppI9TSkLlkf/e0BU2PzXlYZ0HMLyXWCkKV072mHH6MyaMLGpXIWDpA2mho7oiVNJmcFh94IW4yZ5Al8Mloyz2+w+Dju44DU9K+nSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/tpeceYyYHj0O55HsKb0pEgU6wm0e653aMoxVz0HYc=;
 b=Oe4J6TK5FlgV6ynsxiBcImH78jPK5U0R7H5ptnVxp/EQo5oOoxGKdeBwzBkauMlVE22aJ85QgzrjdUuGr/7sZc8CLShpqwNAmjaCQhrZMqLJi7CHFhMeLzgt6tXdK/ZvoxOlhAIwflpvS2gIOwcnxNDSkwH/Jn3FOw46tIQFshnWrvgJBp+r2CnJE6UIJLXIXYQzaZN18mf/PjHvnYjwg+EyFKO3DBRj8z/M2SLy9dk4jYi5yUhwZcuRzsaVYprfhh4PdYdmRVhD5dtU2l9kAuL/Mntn9Nxt6xGjGY9IlVWypvED6YDvrU9SOn2UrFURwjyiO2UuzNOwbA/OC/vBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/tpeceYyYHj0O55HsKb0pEgU6wm0e653aMoxVz0HYc=;
 b=Y//h4KPTKqYGbO0Z3jPqpdy8DEGaGVX6OHAY+ywYqvuu5THC1BemrOM95D+NkLQNSPjdv17icqywhAO9pGxc5MhEe6jEQANp9qiumJvC+SILrLkv/oYWYI0VNMRHjcm4DIMAs9+I+Z4KC2nYkFBUoTBMzQp/ajuVHetUYHG63wc=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GVXPR08MB7727.eurprd08.prod.outlook.com
 (2603:10a6:150:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 07:39:22 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 07:39:22 +0000
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
Thread-Index: AQHbPx8vuTignQOEcE2iGTau3pde/LLLYBwAgADpbc4=
Date: Thu, 28 Nov 2024 07:39:22 +0000
Message-ID:
 <GV1PR08MB10521520ABD7B72D92FD60DE9FB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
	<20241125094816.365472-2-yeoreum.yun@arm.com>
 <20241127120954.0facd34f@gandalf.local.home>
In-Reply-To: <20241127120954.0facd34f@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|GVXPR08MB7727:EE_|AMS0EPF0000019B:EE_|AS8PR08MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 1520c5ec-4d6e-4be1-28cb-08dd0f7fd109
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?r0ZJaUAeflkHBaPZJUlZW5efRs2KY7MT+IJIyQEdiXT0bD0wtt4BV9bxZW?=
 =?iso-8859-1?Q?TwMDIg8zIGMLq5LuXOshvmTFSCiRpKCobmRYA1/SmSEL0kV5FGQN0N7ftl?=
 =?iso-8859-1?Q?LeHcEmg+SZUuKvOzZjhT0khesWJ2kQh+mJ08e3uOgTmbXWw/TQDEhLohJQ?=
 =?iso-8859-1?Q?gkwwWSe8XI17+yeqBUI9aXjE4shwVhkrlKmU80UBnWMkkUFOEmwSN6RDmQ?=
 =?iso-8859-1?Q?MPOa/cmUr6cObR1vHvPvxp00SdK0O9iOgfCzQ1GCfvEBaBoARn96Ev79Ga?=
 =?iso-8859-1?Q?7q7O9uv2CrpNr31MssUk1OV9Q9pgnp+P94kK6X5wy0nkAAMFF9ZTVzk0lQ?=
 =?iso-8859-1?Q?9ubjqohF8nVbDsclv3Riu4eOpcZIxXKepRENXAZMfrnJBrxvkKUrUopYR/?=
 =?iso-8859-1?Q?myynqhO2xki5W+fnc3mOIsL8w7yulM9p8z6hcFJ+j9tiOArKVustY8CfWs?=
 =?iso-8859-1?Q?4z8Oa9yX/uNvNNNDOtJKFJnvMmHPpeNPKK6vdbMYzTM5MPVFWvbvwaWwz0?=
 =?iso-8859-1?Q?2vWIVhLANRtCj5torTXQpR0sxHCzdONO4h/LYkyWOx/YC8eH0fcc5JBGAe?=
 =?iso-8859-1?Q?MVOJOQFp0JRr2gFPZJJFNE6AwkXWNbUVw5ZEw7wkCt4scuoG5GbNs4DRy4?=
 =?iso-8859-1?Q?qgXjMs05ehR5PrumadWeotNrSqV2dEpfeYJS0YMzIxfAEG/v0ImgVjn2VJ?=
 =?iso-8859-1?Q?PyFmZufB0iA3nYYbYY2sF5qhxVAKbJZbLl6d9M11LKVZl7TA1A5hon4J9d?=
 =?iso-8859-1?Q?l76Jdy18O/mhcqEsaIXrhMHheCLtA8mm3lX5IFq6Enqi6xmXtZn6toxELQ?=
 =?iso-8859-1?Q?SZRTuNNSv/wPLkchyYgdV0Cd0uiP5KH4rwJmW0jQo4WZ65MzC4hRBV/Rge?=
 =?iso-8859-1?Q?Zt9VlivNdjd4VX2PIAgqQhn8oMorSLvtvBsFGCd4+KaUQ7AWEetAs6Aao2?=
 =?iso-8859-1?Q?gg33t2B/ZcnFRbONd5S7N3Q0Gw6SZAT4fnctmNhTFLj2l9/YfbmefStKV2?=
 =?iso-8859-1?Q?I8VY+HS9ZyuKE0/qErDKlKKJAPCS/eUuIP82ErFatxsy1TQ+KGL/7ojPVj?=
 =?iso-8859-1?Q?7kkS4HtVRQ6lGMMXaPes8hm5ZAH0ZaHvDlNmzHxzjKbNLLQrlOhkJro58k?=
 =?iso-8859-1?Q?MdZQk7V8WSyQ4hxeVoUEDg2QrA0jHet+KYYIi21lmREUCpRzQJw5nwo0/S?=
 =?iso-8859-1?Q?DRF2ARzRph7/lKQdbrVFjgUDY8HmBzGxHItMENoXjJEsKDiP9HHW/SdDUW?=
 =?iso-8859-1?Q?8GWuJ3GxF5hRNq6osnjjNzmmPzu1VgQd6j1v8Br/x2OiuU2BNdzg2ge31d?=
 =?iso-8859-1?Q?z9IgQ7J+BNBaLov+kMQaupnaftZ3uDtP/KeXL0oh4qyCi6TjWjo8lUWNKn?=
 =?iso-8859-1?Q?XkdSTAh/YuQ6Ivzph7uluFsPt2gn/xsR2JuR6dBk2KqweNXl4bV0Mdt4CO?=
 =?iso-8859-1?Q?tuInV9XX3EfWuLO3WO585MB8IXapBqS3H6GW6A=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7727
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f1421ad8-e3b8-4fa4-f27c-08dd0f7fc67e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?EbXH5wyGgKoqnFNy2eXxB79Ejc/ZryncT/Q3mRwjztiyx0nUsBta01H3uR?=
 =?iso-8859-1?Q?VbUVnr1bELpr/l4bl5j/AkFKB4m+qKQRjbjZFDv03GrFoyux3U2kWpyc3j?=
 =?iso-8859-1?Q?D7Po7U4QunEZK2DtTcqu+H9igEet93lrK7AcWOpv3SSIPWSslrBNgjFIL1?=
 =?iso-8859-1?Q?83bbY/vsixLPdaGonwQ2DVA0H3wYKGmWIsxMoW8+LBETTv4jxFOrg5UOLT?=
 =?iso-8859-1?Q?NhwVsWQxoKwwOfQ0PjFVnXdWNFx284i8d0B58YOUjBU/EomtPdg1NX3UaV?=
 =?iso-8859-1?Q?gQKed3IyVScJ2uPU97zJIGjEIOBQfs31km4koSMf5ozPr5mO85nN5jMtSv?=
 =?iso-8859-1?Q?eplJao/0oIGNrpZhJzaf62wtgChMvyeU/bpzCkFODPEpFjdEZZY0O05IGV?=
 =?iso-8859-1?Q?2WlzVN3cEdl3GhglSUb6hvL4SGAyJ0bUR7fdIIHzdsvYwx0XFkBg1Bb+A5?=
 =?iso-8859-1?Q?yrLqFBTcOfQC2ic7D/6vYj49Sr8lcu/ZcHqI3CzbH3IWQnvdnyxmUBm2/I?=
 =?iso-8859-1?Q?P23Y1ZExAJZ0Lw0Ibp8BuXBP51U10xRwz3XUjzqUD+afVOzo6SbRNDkysR?=
 =?iso-8859-1?Q?YwxGh3to7lBvzxGOXEQk/1TbMfgLM0bHTYY7FiAmjjdSR4eV8Ed+avR2CK?=
 =?iso-8859-1?Q?cFawJjUATzHjG+Rw/l64sqvDKaU10EK/7BVpif9O4MshmthoYNeiCVWs5d?=
 =?iso-8859-1?Q?ywBOBy7lDax4TuHdm5c6YoROMjyabN4uZGIGgf08CDWUfkVdg80AwY+Hr6?=
 =?iso-8859-1?Q?xyavnOSkIdtW1lleAPkbkot5p1zU6yVx/MLVQOydDCeTAV3Z/qhwRa0OWQ?=
 =?iso-8859-1?Q?mi7UNAqwe9gVWYQSgRXwYsCI8LQbkBmWXjHhprSEqywM4GgzSn2QyE7lnm?=
 =?iso-8859-1?Q?pr3g3IdHi5LS59L2xCDcVXTDBTK4ZaZDJ3MNW2YFYtBrGJFWdYWu+jzoSP?=
 =?iso-8859-1?Q?JQv0QLhtutIvITbsWUgMt0W0QrHYF0Ke9y0paRwxe2UxRh7QPw5KLJt4ci?=
 =?iso-8859-1?Q?iGJdj5vG5+Ydg+hXtJJNe448uCaZ527qx1bfVVDYJf2u0aU2AzTzwmd9DV?=
 =?iso-8859-1?Q?qIXTRuW1NCEGXzUsryZEq3/C9yUv8Msz6+5939DqUAxq9j8cA4GJltSzdI?=
 =?iso-8859-1?Q?gYAliw/oWQFOiqDXuRxMBnB1P+/JipNH/PxW6O/wnxQQe0xA3HXwwzM1IM?=
 =?iso-8859-1?Q?JogMIZCZpnelbeF+9yYRQPvQanSTowmC6OpgyTJviW9aGmjuOmqs8MXe+S?=
 =?iso-8859-1?Q?vYJt0vrV/Q8hc5NOZT5a5VOWT73oxdYLul00gdYkWn5jvSXbRGZxlBXSzk?=
 =?iso-8859-1?Q?RRwsFy0ktxoLMQJA3YhyQFRsMs5ZpKDRa0g5pSulcP5BognPlgPJsmHv+R?=
 =?iso-8859-1?Q?3MQaspSW3lCtdM6VpZBza0+rPeUA7qT6t5cu8bU5TeHcWlnUnF/mj24grl?=
 =?iso-8859-1?Q?ZunLG8M28PmePAkhueAl6qZV8ozV4uH17DHFbC7V8M7P2zQAyJPiFBfpqy?=
 =?iso-8859-1?Q?t3z4zaua6qmQMc/cIlQj25?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 07:39:39.8311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520c5ec-4d6e-4be1-28cb-08dd0f7fd109
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8062

Hi Steven,=0A=
=0A=
> We should start documenting what is not real-time "safe". That is, if thi=
s=0A=
> code is executed, we have a loop here that holds a raw spin lock. This=0A=
> appears to make the time the raw spin lock held to be non deterministic.=
=0A=
> =0A=
> If someone is running PREEMPT_RT and expects deterministic behavior, they=
=0A=
> cannot be using this code. That is fine, but we should probably create a=
=0A=
> document somewhere that notes this.=0A=
>=0A=
> -- Steve=0A=
=0A=
I think it's quite deterministic becase the number of loop currently=0A=
determined by the number of preload_feats.=0A=
=0A=
Also, I don't think the number of  feats will be loaded as much as=0A=
it can do undeterministic behavior since =0A=
the number is not many and it is quite predictable.=0A=
=0A=
Thanks.=0A=
   =0A=
