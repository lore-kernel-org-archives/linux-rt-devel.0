Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270427603A
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Jul 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467905; cv=fail; b=bUcqls1+srRnI+v5GHz8JGdYVunYmy5JF82UfifjPNexfwp5wWFxEAB3CcB5QO+jPlKPHRZJ5agVZgMZtSz9wnfJnK4YEU62nYe/VcnW2lygDX8w2mdRMULT3kcFFeRN2VjlyKJksb9YGsn8Gh4ynd8Hw20IZSlhigZ3frT/oFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467905; c=relaxed/simple;
	bh=JAMPwmCANIdjMVsWp9pBqTuzwmJKw+E5KOazEYS6UMQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iHUUF6fTeqqqb6acKy8IoaSudbZqu8vhjQwqoc7SXdjSACbISdK5+XQ36Ey0zl13vk8ZF5ABgCo9rrosL5amd7YuKjHdvABkORHyndF5bGGYQTQupaANxcJr/RlawkidoDiSWShdi6sBmMlUCx9QOvtTjLk/fSnoNefOrJNtDIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com; spf=pass smtp.mailfrom=eaton.com; dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b=G0ocaVOA; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="G0ocaVOA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI522Ts4tyWapsGFFuirkFNTluxQvP0RRIm3XaLn4ymIffTXFYGuI00Pf4eYZmG7Txt4vh5oWLbaI/JF9RD03GhHtsDdb9DjzHxxZ6XZ/fz1q6RiBzMFKBo6qFf6tjiyZz5ukimjfL/yF5/JH7n/WYoRsS7kbCcZTfWuKPWDv5+Gj1D+och4UASkuxhGfJ3PIxyEmwY6KUgL3KXDSQgJ7vDUwTzD9OIdl2OsoRavudC24zkKRGUdildpMVUYMYOPgsIyX0IfUp/uYzfl1A3F5Xp04YPD1sN7/IH/SQOiIAdpgF3d1n0cxxpl9KBBFudoPc1Iu/zKATc7C7o4TgUOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAMPwmCANIdjMVsWp9pBqTuzwmJKw+E5KOazEYS6UMQ=;
 b=sCX9izdLth24DNQx5GHXMp5m/n6r6eGqDKaFXktC9EDPSBhOsoqW+EqZNyXlm2ani7e0oSYPpeN0+QsKxgWXm3gLwAb9eAO+Rhm1fYnnb9ZCpyUJSTLCUlDjKV43ArXZoivrlYWR1kY5EwBad9e79sP9YBWu0V2F4EF2E9j/ysnM1+9qLKcIpMgvqGRUet4nAAPkSSuBUDE3+uU0CQ9Fy0bjCADkKd/CV6BCwdiJfGB9Rm9qp2kYPcNZnhlvSLgtbJQEAIkc+PQj7/86m1dxyC8tXw8WGmE3vfti2sjsf+AWJ8EtRXG6RezQ9VguTkFHPds5KYVaXWdPAcsbZvnnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAMPwmCANIdjMVsWp9pBqTuzwmJKw+E5KOazEYS6UMQ=;
 b=G0ocaVOA8tGLGBH9fP7oq96unVWu3LcJFUYbk/6EphrrcNAXFRsTihsKKZiRQkuH3JAqgUsHzt5JI7LXkJyzkLgO4MfQkl0tbJJC9xri98e9s1AZHsJCyceG5JMwuu70k0nQ+D5qXf4OzXeNtbR/0FzEK2C5kiJsf6g/dnXWuW6kBNlVDYX82ZGMSNTQqUXEWTUGOCfiOoG9ct7K7Tvcyc8+zw4QRAgxb9He4e+ECKzEGfKRdUbB+Gz4Sz8uaN5yfpPMS+RKJrs8XDbQeLERtzr0tcd27TGFsPFQBVOGd80NILz0LFs9ovHzWPy1mYlCwEgQED05Hh87dGW+fTMX9Q==
Received: from SA1PR17MB5553.namprd17.prod.outlook.com (2603:10b6:806:1c8::20)
 by CY8PR17MB6405.namprd17.prod.outlook.com (2603:10b6:930:6d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 14:51:38 +0000
Received: from SA1PR17MB5553.namprd17.prod.outlook.com
 ([fe80::e1dc:589c:22c3:bdd6]) by SA1PR17MB5553.namprd17.prod.outlook.com
 ([fe80::e1dc:589c:22c3:bdd6%4]) with mapi id 15.20.8880.023; Wed, 2 Jul 2025
 14:51:37 +0000
From: =?iso-8859-2?B?qWluZGVs4fgsIEppbmT4aWNo?= <JindrichSindelar@eaton.com>
To: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
CC: "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "ryotkkr98@gmail.com" <ryotkkr98@gmail.com>
Subject: softirqs causing high IRQ jitter
Thread-Topic: softirqs causing high IRQ jitter
Thread-Index: AdvrX4xbY7N4w4E5T22fK9sDodI2iw==
Date: Wed, 2 Jul 2025 14:51:37 +0000
Message-ID:
 <SA1PR17MB5553039BCE5C4C1A68CEFB87D740A@SA1PR17MB5553.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ActionId=cee10a15-8755-4e7d-8982-18b2393435fc;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ContentBits=0;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Enabled=true;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Method=Standard;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Name=Eaton
 Internal Only
 (IP2);MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SetDate=2025-07-02T14:36:49Z;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SiteId=d6525c95-b906-431a-b926-e9b51ba43cc4;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eaton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR17MB5553:EE_|CY8PR17MB6405:EE_
x-ms-office365-filtering-correlation-id: f8edf0f1-19a7-4734-6079-08ddb977f23e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|42112799006|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?j4awiTKCkFigq54tjFUgD3iDqsXTLi14H5Pa95COmxkwMbkCUYTjhuKDE5?=
 =?iso-8859-2?Q?SnlTffrKXhHPdo2J/wHaiuus/KjGZG9P8Unex18uIkrD2aRRVXsj1akWZA?=
 =?iso-8859-2?Q?aMGombZNbwgzgCcRMuKoMnEEIQj6ux3pdNDh6cTFnkb4ZU7x8BNrH4PpkC?=
 =?iso-8859-2?Q?Kjb8WCEfgVuq9Sr/imNkJX3SIK8e4TJtDKS03SxVMEofCCx7WE0Y64osRh?=
 =?iso-8859-2?Q?58c4xeeRS/eOK6Ok/7Px4U8fT3wYkKGhpWXBd/gEu+4C0MKZom03DJoPqy?=
 =?iso-8859-2?Q?cYcl8fq3FeK9fhZ/DL47hjVMsItsGS08HfiXtJ70k+5/IvuOL6+bKlo/iy?=
 =?iso-8859-2?Q?Fy9k5zGq5PYJ+NwgcP91JoTOhrO9LbuADkdXgZS8m1CmC+bLXpHAi6K6eD?=
 =?iso-8859-2?Q?B4/UtoiFWTnbl+3Zpdhb06FGTbBte3jCsU8hpBIh6M9xl+YLGuP4XgYoGI?=
 =?iso-8859-2?Q?SUR2S14ArRQy0q4GX2cnrzp30GZxGg1zVlo25qT9RPbySqsWZrRBtwWntm?=
 =?iso-8859-2?Q?5CtJ6wB0yiKGoGbP2ph4S0tuf5yHIlE9OWDHBqBHFQC/CVjbh9vwUvrCWH?=
 =?iso-8859-2?Q?zowi5LgpkkWOgiowRwGSlQr48rjbpgtwYQfOKR/lrQ5W/z4EosmeXDH/th?=
 =?iso-8859-2?Q?xUj8CM6ciPpFMID+eU+eu0fn6rL/xBlNcnagQs3Cbgi2Y5bXvj5knXjtgQ?=
 =?iso-8859-2?Q?+ZY8b9YYx/oA5NmWhlHiKm4Ru5vqAUnQj8AopotoU26hvKVyx0KqSMO/LD?=
 =?iso-8859-2?Q?ZxksOSilE5zgs3MPybCN/Wu6BjJjZXTK+0kCg8jCQ+04qztQOZZsbJKTqe?=
 =?iso-8859-2?Q?PiXWHEJ2D5gMnyRBvF+mvtsPG6OVg54wyq0PgYP+heWi5f3mRzIfSc4wX5?=
 =?iso-8859-2?Q?AGqutxiotGo9MZuCyTLDmYK3Mjw15AU1VsOHXy26SFM1bCZVEU91w3xLqS?=
 =?iso-8859-2?Q?rqkS416KtAXn3fgtj5gZYYUPv086uy+oSbUiPNmNKF9KOKmV1fAEw8rvIL?=
 =?iso-8859-2?Q?hL+nrmMjEXePUv/zaLLK2a8ecqBIdrdJCSHs8XcHjEdJEjQdPA4TFTYjQy?=
 =?iso-8859-2?Q?s4T/sLv0OZachLMc+W/cnYMcRliNKCHz2vIGkiTuHvIZKCN5WjkKLSjS85?=
 =?iso-8859-2?Q?XTq+5FRQBUz3+2Noo7D9R94i4GBfuCKox4wGxlBtrczM2Yuh8KCr770XNG?=
 =?iso-8859-2?Q?eafil3/X/GG6ju+sXJFVYtBKrFJKPR8tVOvo82/jPPSqEK62hbPMtljj0P?=
 =?iso-8859-2?Q?9tH4xqzwTQ8tpeSgpN8n1DR2QeYDvN+3L84Q26x/A4M/TCynIi/u7q5O0T?=
 =?iso-8859-2?Q?eLYUs/oj8gJgn3NcmM/+J2aDCKvsLmugMri6IYMC0UeioRh819lJTpEMLi?=
 =?iso-8859-2?Q?SdfknErUOJQabZ+a4PHAqLcas4Zga6DX32xtKPDHO1zGwo/64/b+yw9euj?=
 =?iso-8859-2?Q?s077jhz/uSPx9tTi15biM8rLTwVQhMUzWMqqIreqTMlQVh7QwRn3il4U01?=
 =?iso-8859-2?Q?KpcvCHMBZccAvHSLhEJbbTXMhx7T1VOoAxviNnCyEbeZ1Pe7yyqNgm/SZ6?=
 =?iso-8859-2?Q?/yIpo2r9CpKwhlmK5BsyNAWFUI4M?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR17MB5553.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(42112799006)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?zdNifVhR9/EMCNoLkYE2PC3CAr6Jb/3VIL1lVsP95ZNmesSvzd+Wrdddbb?=
 =?iso-8859-2?Q?LpABHcDj5TDf3SsyNli4tOZBH96xskWVgICLeKP3DgthCVHB6cxmTNXvZS?=
 =?iso-8859-2?Q?4PFXCMWrDnAjbtxJYKhW4nLKFi1pa2whMcDx4vzxUfLeKwKjPhzeFBQqdr?=
 =?iso-8859-2?Q?FoqV6y3yy5hHovmEkZccjDccDALb65UzIaVWXfJ9QPQCE3SjGjvKldhxpQ?=
 =?iso-8859-2?Q?8g5jcV1cEwDCnE+reuaL6wT+CfexVG3iMvIp4Ph4sYOWNlUUkEzSgb/KOs?=
 =?iso-8859-2?Q?j+emvx+sD1W99uFQ8FvNvjPMqDKSvuV7qJpr5oXdy6UHv3cgf4DkD0EdYF?=
 =?iso-8859-2?Q?/GcumuCQELeN014bcylccnQStF0vuZb/UBih2PQnx4v25TOioQIuuZ8TR3?=
 =?iso-8859-2?Q?9q6nLb3IGtev6P7YoBHiW7TFc4TOyWU1G28a4o6FiSz0Ql8/Tm4fzvy+mW?=
 =?iso-8859-2?Q?y8exAvDg1d9/jdUDmEcSv4ETOSptSxJqbcyr7w5uvi68stiyGFuzcfRWdz?=
 =?iso-8859-2?Q?epjn2CHsKh+FivfHSuBoLIQ0YXp3WoZ4j+ZKPtojm6jbhov7WUwHffc/lX?=
 =?iso-8859-2?Q?e7kcJ/gHFqp3MaLVsfaPDlZTErU1A2hVduBL/yJIVoScuqukqvJb1unozD?=
 =?iso-8859-2?Q?xde7ehOu4GxMdhM730wVe/qN6R8MTzPvSviTUer+ezfu1owiVPimEeoKeq?=
 =?iso-8859-2?Q?FlZ7AP65zYOIsTakujAVVKx8N5mipj+NX6UsZHP4AmxF3RBVA2xCgQ44Ec?=
 =?iso-8859-2?Q?rkAYAthTCi3W5Gtbln6OuLDAtI8M20rMivuH/fzWLvk7bqnEZumP9skwuM?=
 =?iso-8859-2?Q?M2EMvtibMA9y7Aaz2uTPK1I41zM0yIMtjAhWI2j/amO55q1tY1Cigya/o4?=
 =?iso-8859-2?Q?BAqrPfAFfuMCXXuz/P1ePqKfpn/hHY+L2j8gcRDexkEFjJQBiZtrIAnXnt?=
 =?iso-8859-2?Q?ii0erx3wbwCDI6FaTC3s3veg3iEHeKPppTW8CCyQrS8a1qexpv/y2cUMmv?=
 =?iso-8859-2?Q?RWG7QRBTujPBF1wl8p/Cu2U2rEjRAw8HIynshx/RcbkRU1CYw7iDAVyGx/?=
 =?iso-8859-2?Q?FbZCb1bJGsj25nS8W8s0jSZvbyPjKPNqPi1PO4vz6tHUFpzR1nhmYezzft?=
 =?iso-8859-2?Q?472cq2xmpLm5xcliYZs2sh54LNF3SzJEjljwZFciwMTaZP3mII+fcWJyBK?=
 =?iso-8859-2?Q?yEWl8wu6FVJhs4Ksxv8ldp+OmoUrHschUtjUwalCoDk3N4IE3JG9pBhOKC?=
 =?iso-8859-2?Q?ot0Lb6jV7Oi7hEXORg+CVcnBf3qFgHTGetrAu5UtwL21gPxDVG3IxtuSpB?=
 =?iso-8859-2?Q?y8weIugFqdeh3BiUTQ2fYVbIK9R8sxeAknjihpD7Kbk+YrhU/VRDTBy6FR?=
 =?iso-8859-2?Q?3x/Tb5KmD/ChZHaJDkY3ODWWTnDxQLt9grZ/Hu272nO9Yxk0NEvN+j+05S?=
 =?iso-8859-2?Q?hACBk+YM9And8VPPIf/IRktRM98zGabgpxl9pJn6C+1kZulHt8PDx58Mrz?=
 =?iso-8859-2?Q?0u36Q/LARvwGQdnU+n0tgCTZbLAprF6FQ+jQvDGFk+fca8tPd5H5+7vzx3?=
 =?iso-8859-2?Q?Lj+EBQa6lzcxOAYFpSPPSDCW25piD4d156A9RcTgHXtwj24m9ZbOWUzdOG?=
 =?iso-8859-2?Q?Vy6cvQnXpBmO7TUh/Ja/feWpi+4FPrR2+H+gl9nkU+1Fu5JQxqyMORfw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: eaton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR17MB5553.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8edf0f1-19a7-4734-6079-08ddb977f23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 14:51:37.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmkMwPC5Wmp5UvowdS3812bpGm8oYg5I1j3lNmOaU9Xe5Bc0X9YXLlMTO2tgnUfOJkn3JS6wA4bL/5ABCtZd4ehmZRsC/d81vBuBV0GaSs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR17MB6405

Hello,

This is my first post here, hope everything is right with it :)

Our team is observing high jitter in certain IRQ handlers on a PREEMPT_RT
kernel, and we have pinned the issue to softirqs. However, we're not sure
how to address the problem. I'll describe the situation first, sum up how
I understand things, and ask questions at the end.

We have an embedded system with the NXP i.MX6 single-core SoC, and our
kernel is based on linux-stable-rt v5.15.163-rt78. Our modifications are
rather small and don't touch anything softirq-related.

All of our IRQ threads are running at the default priority of 50
(SCHED_FIFO). There are also several user-space application SCHED_FIFO
threads - some above, some below the priority 50. We also noticed that the
application is raising the ksoftirqd priority to 60 (SCHED_FIFO), based on
recommendations from an external supplier - the reason being the ability
to handle TIMER and HRTIMER softirqs with minimal latency and jitter.

We observe that a UART "Tx complete" IRQ occasionally comes late, causing
unacceptable jitter in the communication. There are actually more threads
involved (SDMA IRQ, its tasklet, and UART "Tx complete" IRQ), and any of
these can come late.

We did some experiments and debugging through GPIOs and found that when
the UART "Tx complete" IRQ comes late, it is when there is a bunch of
softirqs processed in a row. We set a GPIO when entering the loop in
handle_softirqs() and clear the GPIO when leaving it. The pulse we observe
on that GPIO when it delays the UART IRQ can have a length of a few
hundred microseconds.

Furthermore, we found that in v6.6.12-rt20, an additional thread has been
introduced to primarily handle the timer-related softirqs
(https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/co
mmit/?id=3D7f49c1dd9ab0c9f23c526f58241d6cc9d50f1778). We thought this might
be helpful in our situation, as we could leave the ksoftirqd thread at
prio 1 and set the timer thread prio to 60, as requested by the
application. We backported the patch, and it did improve the situation,
but it didn't resolve it completely. The IRQs we're interested in still
come late, but it's now more seldom. My understanding is that, despite the
claim in the commit message, the timer thread is not really dedicated to
timer softirqs only. It gets woken up when a timer softirq is raised, but
it will also handle any other softirqs that are pending at that moment.

Additionally, the pending softirqs can also be executed in the context of
any threaded IRQ. So even if there was an isolation where the timer thread
handles (hr)timers only, the other softirqs could still cause unacceptable =
jitter
in IRQ handling. In my understanding, the whole thing gets even more
complicated by priority inheritance - even if softirq processing gets
started in the context of a ksoftirqd thread with priority 1, its priority
may get PI-boosted when a higher priority thread runs into a lock held by
ksoftirqd.

Please correct me if any of my understandings or observations mentioned
above are wrong. Now, I'd like to ask these questions:

1. In our view, not all of the softirqs have the same priority: e.g.,
(hr)timers and tasklets seem important, but things like NET_RX, NET_TX, or
BLOCK less so. Would it be a bad idea to try to introduce a more selective
approach, where a certain type of softirqs can only be executed with a
defined maximum priority? This could make more sense if we introduced some
IRQ priority partitioning instead of leaving all IRQ threads at prio 50
(we're considering this step as well).

2. Several of our peripherals use a DMA (our SoC actually has 2 different D=
MA
blocks), and we noticed that the dmaengine is using tasklets to execute
the DMA callbacks. This means the callbacks can be executed in the context
of an arbitrary thread (and thus arbitrary priority). It feels quite
strange to me, especially because the DMA callbacks can further
"cooperate" with other IRQs (such as enabling the "Tx complete" IRQ of our
UART). I understood that tasklets are deprecated and it's recommended to
use BH workqueues instead. Is there a reason why we shouldn't modify the
dmaengine (which I see as a very important component in the system) to
make it use BH workqueues instead of tasklets?

3. Do you have any other recommendations on how we should configure and
balance our system? Setting different priorities to individual IRQ threads
based on how critical we see them looks quite straightforward, but the
fact that pending softirqs can be executed in the context of an arbitrary
IRQ thread still makes it look nondeterministic.

Best regards
Jindra
________________________________
Eaton Elektrotechnika s.r.o. ~ S=EDdlo spole=E8nosti, jak je zaps=E1no v re=
jst=F8=EDku: Kom=E1rovsk=E1 2406, Praha 9 - Horn=ED Po=E8ernice, 193 00, =
=C8esk=E1 Republika ~ Jm=E9no, m=EDsto, kde byla spole=E8nost zaregistrov=
=E1na: Praha ~ Identifika=E8n=ED =E8=EDslo (I=C8O): 498 11 894
________________________________
