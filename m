Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F82DECB4
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Jul 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985391; cv=fail; b=nnFzuoPLIYC26MVdB4aWEhKr8VsIi+JWrk51wqbJlqoyQRgiwH/bwtrGiJqaf4BmCDe2MEo3xa0MI78GfscpWGAMrCXqfDK6/jIbuhZ+MApXUUMl98ickJwSHSEOr7lPcXReDVa72dGs/HxvaRWAF20twuBdXK7lPqh68agunzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985391; c=relaxed/simple;
	bh=7tmVtJWGFH7OFJf/TnAK9PDy+wqAe/0Ocd53EkDQqUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YEzaJyg24pVSAdwLM+arXMTFIoq2npTEAfr02bsul6KAeIPpVkY0hCfDmjbILhfYUBtNzvW7OmLgQGSnRIOShl5cYmkpHz5RmUGdv7KA3lugKb9dSn7SM6Shv7fYgQglMiyPMXRYRXzzGztzodu9PdcZybZe+QKI9MQcE8OoIN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com; spf=pass smtp.mailfrom=eaton.com; dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b=OJgoYog0; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="OJgoYog0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGiQJdqk6UhH4jY0FshQED4wfaCSHymJy+Fdf65LrhS+VzDH3jJoMjdu4VdFK5vClrXpLXMxs+EWUzuT9psEAJoHptIrKkCUTlMN9WhuzoVqmIHZaiZk6VcpEg9gFUTUDmBdBdojllc5Vp4hjN/Muqs0KO65ibNLJrmo4ZTT54la8Qc5fyzmiZsEJ5aYre1XcEzN4ulTGc7l/4xA97P+tZ0oBykoR3ZhQlIbezIreyiUQW05D8B2sJNHBftpXxsqAlTF3vRRHjcAj6KEk9IVCU4ulIVvQHVJH1WA6jP4iKdv759TGsCh2zZrLPB51D6AoA1koyUr0lzG47Q9UNeWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71qU+xN/hIcKqUv8VH2EUwZW5DAk0/CvPMFxIpMDAJE=;
 b=xOUKcYHQ7vTr5Ckw/lswI/UG6viVXaIJmC1nx0jWfut4tSZxuZIl2Ggc/ZbbAnkxLXrzW3FkuIe3g4D6Bv4J7/yJ9HxpOHiW7Ww98Vstuer7xkpQs9LiiBDuTVK8x9mjYgJ3ujBx5sHsSzeNQbAwRehOYwiVfeuKiI5zf7X5wkLgQYkrUVFRHKDtGp+aqwbYxEDZbBdWNpti9ptWvSmYjRksP7FkqcTFdwEGpHtvZ7Olpxxu7mrQRF9iv5UCpulAVKZi3FmhjBnPx1d7Y+9Qn/cK8qg+stxcEABmendXAMUHMBncrhA8RciQN/TOsX8W7tckKhEWnCP6OV4ItEq9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71qU+xN/hIcKqUv8VH2EUwZW5DAk0/CvPMFxIpMDAJE=;
 b=OJgoYog06vJ3OJX+8U7quczXgbpn9hhlSYfovzP23kdYi79GBEgvzQgdv354X+TNPZUki+k+pzoOGSJY6zbIELdWWfulx/6C2iG9NYakQXbvv6Ghvh3xKS1Hnw4a1MvzPDoZBdgbrsUj9NvSZSqwMZWD2e+IkEBFcTKwlTGMu4k/FWnDx4A0sljQfLhy897K+CLT/U8K7VnM7zBnXuIbal76VGm+DX6xcRUL9OupatW5n4nCjdN09V5/+Va+ZGoD4PwXKIHInlrQGvVIBN8nySs3qXi776XJp4S2HLxWZvfBJ4ctrsu3CzAt8FVB+Yg7JCh/+FMP7oHq3IEpqX/H3Q==
Received: from SJ0PR17MB5559.namprd17.prod.outlook.com (2603:10b6:a03:388::18)
 by CH3PR17MB6932.namprd17.prod.outlook.com (2603:10b6:610:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:36:23 +0000
Received: from SJ0PR17MB5559.namprd17.prod.outlook.com
 ([fe80::669:b919:bceb:c275]) by SJ0PR17MB5559.namprd17.prod.outlook.com
 ([fe80::669:b919:bceb:c275%5]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 14:36:23 +0000
From: =?iso-8859-2?B?qWluZGVs4fgsIEppbmT4aWNo?= <JindrichSindelar@eaton.com>
To: Ryo Takakura <ryotkkr98@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>
CC: "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>
Subject: Re: softirqs causing high IRQ jitter
Thread-Topic: softirqs causing high IRQ jitter
Thread-Index: AQHb7z/WV/f4z0P2vEGeXptD5Jq9m7QoS21w
Date: Tue, 8 Jul 2025 14:36:23 +0000
Message-ID:
 <SJ0PR17MB5559A9917E0B59AA6203C633D74EA@SJ0PR17MB5559.namprd17.prod.outlook.com>
References: <20250702130909.0bc4702d@batman.local.home>
 <20250706120148.636285-1-ryotkkr98@gmail.com>
 <SJ0PR17MB5559DFA08F96F9A6E2E2E4DFD74FA@SJ0PR17MB5559.namprd17.prod.outlook.com>
In-Reply-To:
 <SJ0PR17MB5559DFA08F96F9A6E2E2E4DFD74FA@SJ0PR17MB5559.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ActionId=b43ce4dd-939a-43a3-b779-feb5bfc44623;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ContentBits=0;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Enabled=true;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Method=Standard;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Name=Eaton
 Internal Only
 (IP2);MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SetDate=2025-07-07T12:53:32Z;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SiteId=d6525c95-b906-431a-b926-e9b51ba43cc4;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eaton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB5559:EE_|CH3PR17MB6932:EE_
x-ms-office365-filtering-correlation-id: bc85d2d1-da8e-47bb-a86b-08ddbe2cd024
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|42112799006|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?faGMyGT/MajBriEgiZd/5xqY7c/qjr2CXfodqgLnkZEQAU9xa8/r/Oo/t0?=
 =?iso-8859-2?Q?XaTXuakk0MA3Z2PGFd8aWrXWBXFMA4LaZtmkrvboEmeTpNuyVBc73Z7Xnr?=
 =?iso-8859-2?Q?LeH/8m5j7FVeUoQQLQtw+Ju/NKsz6WPeqlGVqW8TNSuOJm4s3Y3usqpB8i?=
 =?iso-8859-2?Q?vyQWyURybcK9Gz0gEwr0p9SQ5XQSAJIrrD2HsudqW4m5MI9SCnQEIz4WwN?=
 =?iso-8859-2?Q?H4Ty/7xmOroOvPxJ5XMPPc6VsKIUe2kSH277ld6afArWNbho7gK1f58EKm?=
 =?iso-8859-2?Q?OT3rf0r/p2nCXL3+SdnE9SX3zF1nmDA8yaIuRNqDiKZJ8nx+kz45be0CFB?=
 =?iso-8859-2?Q?1jiKT9HYZFlaaozBH3w3mJyRiPfYK25wkAuD5gWY71ynikpHzkvwW2g+/M?=
 =?iso-8859-2?Q?ET3TESEHMlU1tcIMMW0v7+9Z/EsVDxUPIAh5R26Tcvfc7dOMiapLYTAE09?=
 =?iso-8859-2?Q?Oqy9bO8POhSuYyJRWsCg5ZodfHEBRhBQrI0WlcDTFm/YtQVsiZaDQbViiK?=
 =?iso-8859-2?Q?39aSWX0LxqkQejAveThvUEs2gWjUdZfR/UsIoxVcl9wA6TE7U8ar9Yg9Md?=
 =?iso-8859-2?Q?YCeBf+XT8TtgYbCTQfKH3pzg71k84NvCSfZ/7eShRs4WJ7NGVcfxSnpyTW?=
 =?iso-8859-2?Q?bc32xiXhoXOQ1Z/ezuOstXriiJ59zNy3vh0VHbON8qMFi2swx2EX+wBzU7?=
 =?iso-8859-2?Q?2qwBuIqh2xoXVjQuvDW21CTpC3SepoPUet3ohy5EPz8Nrv9LGaoTdd01f9?=
 =?iso-8859-2?Q?3MTwAbBqvL7BeH87e+ukZbxSQw5585LRpQPhWcpqyaG66j1x5qSV0vqty+?=
 =?iso-8859-2?Q?FaHyOHy/AjpT9TDn+ZbUzkwytjoGCU5AMPz2fvRRp7amqDcEWkMKw986f7?=
 =?iso-8859-2?Q?tp0r1ptRH4BYdhGnox92y/6LUjqVaU+yzNmQLoCasOKsqHH8e0t+v/yUG0?=
 =?iso-8859-2?Q?IpRzgam08sNqpV8QmoewTBT1wEj2bAIYV0zXV5Xn5C3toHpUes2QuG8MSK?=
 =?iso-8859-2?Q?uDFRtpcZNrh0XydXGN+SHQe8u2my8xCH0TznOviQnHZ40f6BxymHa19IA4?=
 =?iso-8859-2?Q?zdqdMQHYNrm1KCQGY+Ql1x7opyYjBZFyUyL4Hc1Oqdbyj9IORIEMP8Mqz9?=
 =?iso-8859-2?Q?cOm+5c+9WOslOaMfcC+DlHCPLa6eZ3A7JmfnBGf/xlWLnAq9c/KCd6HP8u?=
 =?iso-8859-2?Q?RAv2KTZ2f9WPfkIRBtVjIhw48LoQszDXHRgX8gNgp2Wwupw1cNQ+4NiVNQ?=
 =?iso-8859-2?Q?KSvp4iMzBmuyaA5AfkHg43IUlbYNXsWKmfMhBqigWhskYza6k8j0Z4Mhm9?=
 =?iso-8859-2?Q?ObgXSTNbSbmbs/w0byO5XUll5ckq+JaWzJVMqwGbRvIYp1NoSxXF8WsIFS?=
 =?iso-8859-2?Q?H0HbU+4yIiEd2+ShGycVu532EH5C0Xe3I37p2SbHBfoOHFEwr1V6kD//BQ?=
 =?iso-8859-2?Q?LkVtwamytPAhu10QbOyrZFRrk7b3sWKV5daz5NDrlr06CVLt3waEq83I02?=
 =?iso-8859-2?Q?Q02Eqrbzti6y4TzhCTDSEfl9rKrmw8gtD/iGJqn5PNPvENY38q2eLtwFfI?=
 =?iso-8859-2?Q?HucXRZiYxkJZofLvOYat4M8GbBS7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5559.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(42112799006)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?280V8WSmomakbCEcFg0GxErBz3JigSSElf5EDomzc1CcoRSfpKa/f02zWU?=
 =?iso-8859-2?Q?Sf+12RG8jd59wXxasR8tJKK9xzQFma/h4laRn0x+dpG7AuZ9hVOFHkPxYr?=
 =?iso-8859-2?Q?QC6jmiAGMBNWnlgUp1Dh1AvG0/IZF1p1X1oHtDyoJruObyuTWVxKunHX6G?=
 =?iso-8859-2?Q?OiaaFqfAu9oPhUdSf7yU8q+7YlrWeYNEY6T8KirqPe8uhxf2ONadrzi4gg?=
 =?iso-8859-2?Q?ZHppC1fbl/C69daJEk+eR3bZ2+X+AwUTCZFRd9NGaZep50p7iAMlt141Jn?=
 =?iso-8859-2?Q?jLhyPXh2pHBLN2iKqOyelsnv8rxzvVqIIR0wnrK82zzjyAIX1+IlgFbYnW?=
 =?iso-8859-2?Q?14j87KNGPcoFopWXqJtErRKaG+N369MKg5acgQxmT+RgtYzHZlkhqPHjZd?=
 =?iso-8859-2?Q?V1yrz+89awtZkg5RC0jVMfg207z4WEfv4LWRtThEQLaJtHS3E5JlRktt2M?=
 =?iso-8859-2?Q?YKMuLEtCvWW4HAZTnPnXXu7j3KPKhz/CgLOdbKcitnz5UQPZo1A3TDN/hq?=
 =?iso-8859-2?Q?gsFteuNX9fvZ6om4S7ZZTPNk1/Wpsod1RvLIJjRFt1SRpe4StiBklZtXZJ?=
 =?iso-8859-2?Q?miPjLJ2t93GCutfp+jJtBYbgwqNnPOF+L3Cu98H7Pe/el4gxCU2MZCz8Dp?=
 =?iso-8859-2?Q?Lngf6lkaqkON5NR/OItKByTEPbbWJaWVnr2dQDVKU/VmeUObiD71+5HsUX?=
 =?iso-8859-2?Q?bhnPVcXGHZ3w4vWvast1xrWdHrkkKe9h1JRLxJJ2TQWc/JpEo4Q/J/e9PM?=
 =?iso-8859-2?Q?s0tZBz6vf6r5rKJ5EqCEfj5whLQ5XRvhxGWVdQY7sE8uqSlafiyncAugeg?=
 =?iso-8859-2?Q?RdW/mTORU8qqlG3UNla6RNJtxYSiQmHfjwRkYMUmrADRYec96diF19Xjh0?=
 =?iso-8859-2?Q?kM5ixvS1WtSfBy3uelfik6auLDVCiH0L81WwPJH91y17zmmgM4l3oXer/4?=
 =?iso-8859-2?Q?7RpEGECUVvU0E4OQO1PjA5D+FInhFOXGxYFqQLbQxENkZ/0WnaeKmyuYOh?=
 =?iso-8859-2?Q?xMvfuKPcX0kBsjCTwCDKl7csfHdfUsH/6hFDRwUEd88rpSCay8Cv2y/IDI?=
 =?iso-8859-2?Q?u3FsB9cCv3CAT8mKbUYO0lWv8SdWp4c5SPWU6WTkPyv07gdezSc8p6cjMS?=
 =?iso-8859-2?Q?RrSY0tW028mVkrY2MKuYzIm3YNajVHAvPtJjlFPRIRXfMf/Sni6CjEOgDr?=
 =?iso-8859-2?Q?Gx3UqXmO8JgJwvHpl3jNQxYaY73QdgblF12gHAraE7v6rpw0Go7SbXRAA+?=
 =?iso-8859-2?Q?l6izRSGkDnxolJWnZ9s3zdiNdwDS4sAfg+t9sx64iv2eJhMfTYZmpGvY5j?=
 =?iso-8859-2?Q?D4tHvP0xmGhCjnywxVjTaMi8HNBK5K/YY9/ztWaPdsHUChT95a3uOJ7K+Q?=
 =?iso-8859-2?Q?jdsdzKgpawsRqZ0NNPcXpeu0E+GiCGFFLGHoBsn0EgPkeLTBoFv+CMeur2?=
 =?iso-8859-2?Q?OqgQXV7+ylIOREvFhuWURbG9JDJ60bpl1wLRgEQhAcgv1Y2vA5j/YqrC+g?=
 =?iso-8859-2?Q?WzBtgmqEyXzawPOkU7xd4HOP+oBu4MeCGumzRapUUkvg9A2sExFQD/dkhq?=
 =?iso-8859-2?Q?WBnRK8HJJpq0Lw0vtNB0hJcnXTLV8PB1TkE8lcv7T6ZKrykLyh8EQypI9A?=
 =?iso-8859-2?Q?JwxPIhDo7XqkPay+lAuCcvpaDu3IAs6fEc6jpmXf/VopxCR7+kTZmspQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5559.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc85d2d1-da8e-47bb-a86b-08ddbe2cd024
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 14:36:23.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03WPbrLgHn/BSyzM6CrdjhI92v6FfgWxRcy/g6uVMFFt3PDa9PQJV0l7GLpf9n1p+ZJUr6JqYZfof43kuCS1nBdph91eLUTL5PZp0TDbqZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6932

Hello,

an update from my side on this:
> Thank you for confirming this. I am now leaning more towards trying
> even more separation, to achieve a state where, if handle_softirqs()
> gets called in a context of an IRQ thread, it will only handle the
> softirq raised by that thread, leaving the rest of pending softirqs
> untouched.

My way of thinking about this separation (either only for the timers or
for per-IRQ-thread) was based on the idea that inside handle_softirqs(),
I'll only clear some bits of the per-CPU pending softirq bitmask and
leave the rest pending, i.e. modify the code mentioned above to
something like this:

    // ...
    __u32 softirq_mask =3D 0xFFFFFFFF;

    if (in_timer_thread) {
        /* when running in the timer thread, only handle the (hr)timer soft=
irqs */
        softirq_mask =3D (1UL << TIMER_SOFTIRQ) | (1UL << HRTIMER_SOFTIRQ);
    }

    pending =3D local_softirq_pending();

    softirq_handle_begin();
    in_hardirq =3D lockdep_softirq_start();
    account_softirq_enter(current);

restart:
    /* Reset the softirqs we want to handle in this run, keep the rest pend=
ing */
    set_softirq_pending(pending & ~softirq_mask);
    pending &=3D softirq_mask;

    local_irq_enable();
    // ...

The issue here is once the IRQs get enabled, the rest of the code using
local_softirq_pending() to check what's pending can immediatelly start
handling softirqs again and again...
I thought I could do these changes in a local and relatively non-invasive
way, but now I see the use of local_softirq_pending() is spread over
multiple places, also outside of softirq.c (namely in smp.c and
tick-sched.c). It appears to me that the approach of "let's only handle
some softirqs and leave the rest pending for now" may be very difficult
to achieve when the single pending softirq bitmask is checked at number
of different places and it's assumed that whenever it's non-zero, it
should be handled on the first next occasion.

If anyone would suggest a different way, I'll be happy to hear it, but
I don't see any reasonable approach myself. I think I'll focus on
different ways how to reduce the number of softirqs occurring, maybe
trying to use something like BH workqueues for some of them (NET_RX and
NET_TX come to mind).

PS: Sorry for the long gibberish line at the end, it's automatically
added by my company's mail server...

Regards
Jindra
________________________________
Eaton Elektrotechnika s.r.o. ~ S=EDdlo spole=E8nosti, jak je zaps=E1no v re=
jst=F8=EDku: Kom=E1rovsk=E1 2406, Praha 9 - Horn=ED Po=E8ernice, 193 00, =
=C8esk=E1 Republika ~ Jm=E9no, m=EDsto, kde byla spole=E8nost zaregistrov=
=E1na: Praha ~ Identifika=E8n=ED =E8=EDslo (I=C8O): 498 11 894
________________________________
