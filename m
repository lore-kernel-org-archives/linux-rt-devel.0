Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA1218ADD
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Apr 2026 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827237; cv=fail; b=AG4HDA8aG6VLZ0BbPASyo4Fd8OOG3koctpY0u87By1OMd5vPp7qcNGtE+YwMIRR+4ItORZCIvx5C7FCKqYmavAXVadQqU/QwnP4kPEB4God07RQ+UsY7vPnegvrMgphmKHQabkj9keckoF9WZ0F9HmC1ErKD4BPHKNS9DK5GkE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827237; c=relaxed/simple;
	bh=X3u/8FYgJKEiRfihGzF5T5v/zZzg+J6bE332W03nUOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mUbmkvdIyNFhGSgUT0YttO0D1YHAWS78/Biv4PN6tYSk/QFHDwnNNIrQJHf2j58FbK6HJcPYunmNDLXZrdA++f0ZeoR9/lw1Esxu2ZGvWPklU9B7kd0JV+yllKwipNOvzM7xh8l5ppS6nsXAt3LzCO1uQDtbU8A8xibbkY433HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0gXIuUl8; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0gXIuUl8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkA38mpFbrhyjk68n2mmmDRAggKodsi7ieeT6ZUzYmJRUlnWD7tb2O2+3uAorJZXXiGnCCHyCsIPdGGaVCZU6902pl5khmB0PgZjdqv070B3+ohkL0Q9qzTXSo9Fb3iUzkr+E+OhkDRtYvXO+uLn2KX6d4QasMguzfBLOSgboMVuqqeDAYzxh97oVcr0mlqT0GR3mxkIxN3hQ3s1TNPYW1jMmIh3Cl6Xs6lyCPpJXQ075TWaX2r0SSwJJBXc+2qZOrjCOhoToLsOaSts2im/hAp5u85nYeWEzvUi65pWtf6c2HFQ2Mh3Z8yKmY1bIHqoxBEhAbDEo/hPhVxQrOCswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3u/8FYgJKEiRfihGzF5T5v/zZzg+J6bE332W03nUOE=;
 b=Lfi6Sry0XSZS1Z8GY/4LnEhSLRRuqGETxZDw96UqhqL0LxoVmspEk8D7+nuCYqimv4x2vgK1rUC2jaZ6+K0NJt0odDemVkcWuwSg8kEl9t8tAdpcnTubKFZokNzZsnz9tChseqgpVeIxEaFSWRKWrRYcfyFyJOMDrCKg/5GSfpH/Zfb09EuvR7zdwpnhUxTo+59vnzmC5TAJtz0IMWwKw3FBgZEyk0O9dqB9TGtcmv0KWqVNgyurrr4GkmV/a/cl4OhKIyqmG9JDdzjCuYdMGg+j9wr5iCM/QCL7UgaTVzUe9aS7SJaX6nO+jCN3iPjDGWseA8cVebgR2sxxs7Fy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3u/8FYgJKEiRfihGzF5T5v/zZzg+J6bE332W03nUOE=;
 b=0gXIuUl8E6CUeRo47I75ZDcoFeo663IFAjvBXyNoUGr5IXwae0JLFTgr5wrEZUxhNHrfoXLQH69aiWUfN0Ho9SB/t4ZPFQiu/QAFwA6d8C1MXha/eDAg9T7IbSpYCfqhHi8GlFheZ9PXFqPH2TcpkMqRZAIMwbOqFuziP4fgdWI=
Received: from IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 13:20:30 +0000
Received: from IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2]) by IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2%3]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 13:20:30 +0000
From: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
CC: "Varone, Dillon" <Dillon.Varone@amd.com>, "Hung, Alex"
	<Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	<tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org"
	<linux-next@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Thread-Topic: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Thread-Index: AQHcyCLT+fim4XOC0kmlAbF0I1GUirXWuPGTgAAB0YCAAF84wIABLwbT
Date: Fri, 10 Apr 2026 13:20:30 +0000
Message-ID:
 <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
	 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
In-Reply-To:
 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-10T13:20:29.713Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6307:EE_|IA0PR12MB7553:EE_
x-ms-office365-filtering-correlation-id: 04cd7f45-fe72-45fd-47e2-08de9703f03e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 V4c450OC/5SHwp7TIJHb/ZrKAYTnSTFq+Gj2WvnLJWQZC9Y1bDRR/zc6qZBqTuGqKTRZFrvSK0iJXQB7Gt2YbayhDP3FkZPB7t1eWlp9E2bSgeN/VrhTE/GJV/J6Ci5JnuKfQrdl5Iadc/jDXCuyzgfMkcpC1ManMiQy0qLQdkH3Gw28cVVUhDeGGlVbCT3dWfonG+gehB28RHt99xvCDhDhrd3/9aQSUixc3NEjmc5H5KA156GBYeBgt0ju6pNDgS1vRcbmMeve1a7QtrguPD4e8+OoDJDSiBhNYhopx4F4CvtgIAur4Xj6+VCqzw4kd3h2zvljZUF32lK3trl9CkbegqMHY6XT6agvPnM2YA3oGAN+L7lnPOMQpzxRnhXnLZQB5vVjFO+Z0egDA3FRyOMZwmbTotPQVMx7MnoVi/kstNuQQ6t6VG3p+rEv9VoV5CQZxaScxEPdFx5bzFp07ConYTILXCJ4eXKswBi9sph2+9b6CkzaWr7t/Rpe3i+xaVbvfOpRqXP232dY+0+jHikHeK6tPUO0IASMLa/t5WgJ2529Hxb3dMfC94f5omj9TVo99RCVMtvfcbRrhXOWwZ/UfYJWyRSQs4bw/dpeQwGfgB+SmoDFtZQ6Q/CqDP2COtxD9Cye8i90/6PAk3ggYNjXtmAotMi9NZqs3UH65N8w/sGY4ysYtVbQNlQXrz1uz47483lIj0mdJ/NrG8jqjw9K9P7GTkMtt3rEe54AyMnsguUivtSmD5olFOcBBZN2nsC/dT825GFiKsl3zoQNAJYXtlSLSBhUvUkS9ydlU/k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6307.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pKQvfqIwr7HkjtySscyBFIBhCsSLcBme65dl1wE8JtAqwDC9gMu0f+a3ig?=
 =?iso-8859-1?Q?bJy1b2onyDDBc9aidLJ+oZASDkLthdwb0SQkjWuivXNLbPtNIUQ6P1Mvzg?=
 =?iso-8859-1?Q?HS0INFC6g5SEIm50G88SKzOjnMf6K5xzJ8MvRUBmdD2sVU7m6NLqnNikYP?=
 =?iso-8859-1?Q?hDWZ2uL3se2mSp/g8Vc2cS2Ov69BIUkmBbfDT/NOi+2S+z8Pm9sZNvleBT?=
 =?iso-8859-1?Q?9lMU7h2sRTEpBj4CLFnBWyd8HeQV8MEAHZjDiml4Un9+4YOYm6Trwa/Fuj?=
 =?iso-8859-1?Q?+rJ5xLNqo9JHNsXg2PYlJPBJiByyAOHpXA5UYsZ1NgdKpEPNUvQpSbDqiA?=
 =?iso-8859-1?Q?vNvLeEyj10tSL95vJfjmWMCo17MOO0ih/3/QpSbIqvtT+egT6+Gbb0exMn?=
 =?iso-8859-1?Q?41gXVQ6fvAmlA/mrHT2DnYOYoxC1R5FSEFZf3xuWU/vYXmrM8TbCIHKv89?=
 =?iso-8859-1?Q?AxaJCzTMoklZRtMPXhbYWUsRviSzuP7vV6pkOlzxHA57wHduejsVRqpVCl?=
 =?iso-8859-1?Q?/ZHjEIZNEA0VpWMGam4ct5z3wPGotakH7wDPCKDB+jQl7ZVSDDHqJ0gt/7?=
 =?iso-8859-1?Q?l5uqbnrBxgFggpUqjIAcGN2uHdknpl+oEtjExmGalPxATGf33Yqj6Vtci2?=
 =?iso-8859-1?Q?Y1B1gvn3GXvZnbuyquoUOsLwBZawL7thWr3Rzx0GX+1EUe1vqBFQJCRtbk?=
 =?iso-8859-1?Q?PTHGvq6iCcyXHyfYOY5jmxvF9ROgzJ8XEAu/onM+UEykd4lystALWJ7KXu?=
 =?iso-8859-1?Q?1jesGDFZot/+zfBgzMTojtZWnLbLflHaFVSNC8GUvhnQjBSnciu1U8zbli?=
 =?iso-8859-1?Q?qS6k0zeo29kYUiGul/ygOL2+VxfB3ovIM3mwOVBWSP3HpCk4X0zRGqGhjw?=
 =?iso-8859-1?Q?Mx/NsQPrU7ZJPTze7hA2la7hd5h+5d/wYzAv6WplhXuwvMN63blgC7hnsd?=
 =?iso-8859-1?Q?F9lwvVpKol2f3WE02nTr81sYxsNLsMpJgZn4gxVzSqr+b1DSgAKfjlF/Q4?=
 =?iso-8859-1?Q?lwG3jjeOqYUWPSAwJcnmt/hAz4j6cEAO7FxHmBiE2qj9tmkL99I9GGPvXX?=
 =?iso-8859-1?Q?/RrNc++nDBjy09pQFWbwFf546EllRVbNwEFa8EVhaSS3S77Vz/2aWMicI6?=
 =?iso-8859-1?Q?iZ7oyKSxzIMC78FqHMaKg4viZ9jwyMb1Y/5D+Q7SuZp8Fro5OCiGE4f3S7?=
 =?iso-8859-1?Q?AadyxXXUqNeS4cXfPq6FepCSgFBytiqeN0CKL/05l6xuCNjsiaWXYMp7Lw?=
 =?iso-8859-1?Q?tTfG7bg21w9sj5wk0MiWSx0ozSNQ4yhE/gx6GjllqrAEnlGuRCfbSX0h0l?=
 =?iso-8859-1?Q?91FRiyA1NcUTqcvs0NBlVe6ggveO22itXx5BuQkh2yD9xO5rf3ZdHQJ880?=
 =?iso-8859-1?Q?QVD8Gx7FtWOh0RoK6MsCX/hMliXx5nqHqxW/pD95UTJvWqD99Y2G5J6OpT?=
 =?iso-8859-1?Q?3zitMFDGXObcCjIWV3R+YqSBZHHih+tutXCi4vbzEuprmnb6orUdh24De9?=
 =?iso-8859-1?Q?iXGhJLyH55qmWwuETH1kHbeJnzH/Jv7EL2LCaPJl09P6fhS82c5EwbGG0u?=
 =?iso-8859-1?Q?2XWyKAqxNgr95y+gUmerfzSsA6zDjVaTOVH0s01FGNyi+fkKnrneH+vwX/?=
 =?iso-8859-1?Q?+WtXDDc3kuGHFp2vUGd+LegauWvBn1jcDHW8wkN3BWzgWFrW85mCKCw51j?=
 =?iso-8859-1?Q?A6gy6dDh6aoSMkTIaSuerk49G1Jg4L7fak0n7lPcDO+jiHznDmxaj9yWVP?=
 =?iso-8859-1?Q?mBXCcjExuuRjXQzVrGcl3L07XG20VCHek1Fw6jwnDykgbn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6307.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cd7f45-fe72-45fd-47e2-08de9703f03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 13:20:30.3238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qs9gcqBYkSyTBnAmEKimoiezi32ewzqQl47Tqn/0yY9cCVUhchENDG07xnPfEqQZ3Kxal9Z9wSp+jHi+NAwQjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553

Hi Bert,=0A=
=0A=
I identified root cause of problem. I had to do modifications to mentioned =
patches to work well with PREEMPT_RT enabled. I tested it on my local machi=
ne and it seems to fix the problem. Now it has to go through internal proce=
sses. I will let you know if I know when fix will be available to you.=0A=
=0A=
Kind Regards,=0A=
Rafal Ostrowski=0A=
=0A=
=0A=
> I was able to reproduce problem locally on Ubuntu 6.19.0+ #64 SMP PREEMPT=
_RT=0A=
>=0A=
> Tomorrow I will do my best to fix it. I will let you know by the end of d=
ay tomorrow about my progress.=0A=
>=0A=
> Kind Regards,=0A=
> Rafal Ostrowski=0A=
>=0A=
>Am Donnerstag, dem 09.04.2026 um 13:30 +0000 schrieb Ostrowski, Rafal:=0A=
>=0A=
>=0A=
>=0A=
> [AMD Official Use Only - AMD Internal Distribution Only]=0A=
>=0A=
> Hi Bert,=0A=
>=0A=
>=0A=
> Sorry that you experience this issue.=0A=
>=0A=
>=0A=
> Do you have all these 3 patches?:=0A=
> "drm/amd/display: Move FPU Guards From DML To DC - Part 1"=0A=
> "drm/amd/display: Move FPU Guards From DML To DC - Part 2"=0A=
> "drm/amd/display: Move FPU Guards From DML To DC - Part 3"=0A=
>=0A=
>=0A=
> These are highly dependent on each other.=0A=
>=0A=
>=0A=
> Kind Regards,=0A=
> Rafal=0A=
>=0A=
=0A=
The crashes also occur when all three patches are applied.=0A=
=0A=
Bert Karwatzki=0A=
=0A=
=0A=
=0A=
=0A=
