Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691329B218
	for <linux-rt-devel@lists.linux.dev>; Mon,  7 Jul 2025 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893547; cv=fail; b=AMn7wBD8TVbCi6rGVQ/iINYeMNli9Xpt7D+PVGDLd84zf9E57r38Qp5ACklnpcdYOWvYVAjXF6ziVqsddBisL8oLS5vvAyyEhp8/FPvCeijlPHix6fg/5fwnd3+3OBS3st+tRxWmxYKQe2icsjcqykgMFhfYFUgu5eBrZs2jBRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893547; c=relaxed/simple;
	bh=IMWQ9Fmxk+wGk96y9gLSHQPjQpI8vXRLqxMR7GhT4fI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAi5r0Gl/MV2WTFQu0Ab+/FQzyr1xCR6pmSalqdwVvivoBpOV2/QoZGlQ/53j8dbCjf64+2OSjpP7rFY4I4ccsnXICq7F8w4H7e8ab74lLxvdEtrA+sU5CSkspGEyTSCQsd9jEO5Gn9wNas8AwwYOKu9/1mN8TVwjFG+BKqUY8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com; spf=pass smtp.mailfrom=eaton.com; dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b=rf6Q6WIZ; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="rf6Q6WIZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV6Agod4aRdr6aJrQSb9giM3ImXi4gFV/CyUxIRQcl2kxe1IpUf9WFSfO8wbpZi+xhJ7G5P64lRZ1W2eLyFJIWjE8cPXxwkiKNE2yjk1KY6Z4kprLHVkpSQCJGDFx6XtRm8C+fr9eGZAQWzD5UjQT8Gyi83/iXB4XcrkinXzlQEl452Z+VO6WPFl2p0BRGG2bkwxx8uvsRTrQgA5qOAyv9+4Cib5T8ZFeVGj2Q0FU2e6BS1GK6V7nxQ/T20vdLYul3lOQy8tfs+LX3leERnmDFXj5eKGEyxG4uIX12tm9X06mclCVJeXmGVfKOLhe9+FX7Qc6MpFOLwIT4kbcNFGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPvyGA88Bof1OXz3y1Fy0NccWHbaD+fRKcP1kNbGvpU=;
 b=L8LtrmEzzeqCQs+37y7IWQU8uVD7FMMW7QWt2qTXbh9Vqyh09uXOE0vMIPrYTW1ITR5FIt8rAIsh1pZJutjBuBagm8jCuu2vDBtHnUUqfJSqupAlM4dh174WgyVaSs643y3ZZZCuIOBxjnuDNFHjuye9vRAV65x8W6YjUsnHNxAI83dfsaZlz/j/WDYEP3hfbXynFARd6dTb/hDgWSjDBIsoqwZ/Yh3BBek2Ng4ASTBXL6H3qSUFjEbvqGp7EaFLdZKgq5XmIe+8wVkCj8xihRXOzIPFvaptzAnbVB/bhiXLFXjumVMXmnORofGC4+0M5X9Ye14mk2fHlWo2qg1F6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPvyGA88Bof1OXz3y1Fy0NccWHbaD+fRKcP1kNbGvpU=;
 b=rf6Q6WIZDTv5rdMc3KZm7du92fD2/jlXwXN6m/2k4FDB2MJQKFRIitzh7dw+XSws2DOgtMqRLEsAQWvlpNb0riMWpbDKl/mRWE7SkfYYYy65kNYIdYKPAdejvb9jpUZTWCin5+MvU4H+F76L8dIxNMvEou7Dr4C/iLvP180TS0Z/CaCJCPS5S/aSpI/Z0cTkKuCGDLtYaWfeLy0KJzQ459AYmuieRtgC636KhiSq+Lf5a03oMxFlnMRCoFBdszcNMazq+Z/CghVSLXe/6FGg6smUaT6NBmp+kioRx11Jv58IuqhMpdwO74w5Jja1ZKXukUxmlYdOgeRlMuccGkvoqw==
Received: from SJ0PR17MB5559.namprd17.prod.outlook.com (2603:10b6:a03:388::18)
 by SA1PR17MB4737.namprd17.prod.outlook.com (2603:10b6:806:198::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Mon, 7 Jul
 2025 13:05:41 +0000
Received: from SJ0PR17MB5559.namprd17.prod.outlook.com
 ([fe80::669:b919:bceb:c275]) by SJ0PR17MB5559.namprd17.prod.outlook.com
 ([fe80::669:b919:bceb:c275%5]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 13:05:40 +0000
From: =?iso-8859-2?B?qWluZGVs4fgsIEppbmT4aWNo?= <JindrichSindelar@eaton.com>
To: Ryo Takakura <ryotkkr98@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>
CC: "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>
Subject: Re: softirqs causing high IRQ jitter
Thread-Topic: softirqs causing high IRQ jitter
Thread-Index: AQHb7z/WV/f4z0P2vEGeXptD5Jq9mw==
Date: Mon, 7 Jul 2025 13:05:40 +0000
Message-ID:
 <SJ0PR17MB5559DFA08F96F9A6E2E2E4DFD74FA@SJ0PR17MB5559.namprd17.prod.outlook.com>
References: <20250702130909.0bc4702d@batman.local.home>
 <20250706120148.636285-1-ryotkkr98@gmail.com>
In-Reply-To: <20250706120148.636285-1-ryotkkr98@gmail.com>
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
x-ms-traffictypediagnostic: SJ0PR17MB5559:EE_|SA1PR17MB4737:EE_
x-ms-office365-filtering-correlation-id: 0f39bedc-e1fc-4567-5b89-08ddbd56f939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?r8aKh+ecH0jJ/msZz80qP0JElSYsrs9S2ObQ8NSorscw/jCGI/4UJUvxgQ?=
 =?iso-8859-2?Q?h6WfmMYrYdIKvoQrciERUApA3H+u52Mrjj7yZcFrAAIA/rVNc0ZMN03l4f?=
 =?iso-8859-2?Q?FdgwEPccZd2hqmMSDuZJLYvLR6Pu81STXynXmwPA7i42s8V92k2kpBZNu+?=
 =?iso-8859-2?Q?ZMNOYW2Rvg2zJvsW1SJXrrWnN69jItCOkUcVhpDD3aT3G/zUaMKW0LW/NY?=
 =?iso-8859-2?Q?JPXJSFeF7woKPJgXm5uPn+k8EgDuxQiE7mwA2cNrW/APVwagWBMgi0pKNo?=
 =?iso-8859-2?Q?5OSek1W0pQnRJtsmBIZCeKfIb36ObB6LKtOz5GXAuQtx+9Mh2P/Kw0oGd+?=
 =?iso-8859-2?Q?+W5xDq//VURdobexW89xaJiOlXQnHKsDsKdZVFPsCl5hpYfGfjb26ecj70?=
 =?iso-8859-2?Q?rBVfTlZmBqr1SXZJ0pWFJ19rkkd3vlXCUUOIa102UHMEgU6EimHupNngSO?=
 =?iso-8859-2?Q?QoaTMkj+9b89/VkOIu1CRKKopvIevBUtH6uP1Md9UPMVqccjAWVlpd/xtT?=
 =?iso-8859-2?Q?iJQZ7tcrjyoxbtGYYYuTqsnR/UD8RD5+3QIdBPdwmMeYnFgIxjV5RwGsY8?=
 =?iso-8859-2?Q?ce00ALKKxUJexH1fRMYZgNKzPPzyiROmnKUOJRMYKBOUzsIdptZgRirSUZ?=
 =?iso-8859-2?Q?kBkhvo42XqMUoQlgdsGBFOVCSNUBvHkr5R1grl0YDFIb8bQdq6tMmZxgcC?=
 =?iso-8859-2?Q?B0x1Yle9IW1YZvX0RyjpFertYwtzfMnC9/YjgJ7ddnq/PNGgRgXE3sWHSQ?=
 =?iso-8859-2?Q?FuGQV7DATDL1MUcNBkToGPbuS/eY0jcVmueOCE5o1D8iW57PMBQogXGLVf?=
 =?iso-8859-2?Q?n5TmT5dH47geb00LdnujB4+qffViw6yKjqOPrPOj9IlCz1BiTrfeVcglM1?=
 =?iso-8859-2?Q?qwQujfg0msBJorD6PSxcNNvLRQE7nz6nQGUlI7CbtUzsnVzHcG3X8HIqpX?=
 =?iso-8859-2?Q?zChdpUghc5J3UIyeADV1T6e4QI2Tu6DN0L7H4M1bLb/4xREAheaUnk6zqd?=
 =?iso-8859-2?Q?SF2H3xBKjCXyTP5rYuwAifVtX5VIxzq7v8bmbVTQP3j3XtXBEXPdhcNH/U?=
 =?iso-8859-2?Q?6gKUI1Z94cZT29mCaq5DKdcjh+vI+rgg3apYpkxMlzHxVQYBkWaC8nEy9n?=
 =?iso-8859-2?Q?Qn6EkNztkBDaDM8qa8rpbKqM9cZWO0Fuk4OfTRkR7FoGdy6mqqbkmMmxSy?=
 =?iso-8859-2?Q?hHsNCegVpNq1u8Auteom03mkduFF126FUQDkDr/7yxTyn5VmzjODj9g8f5?=
 =?iso-8859-2?Q?3TZwbOe+fmhWBBo6732QyIecSAxIVbHNW8iaP/ncc16oqcBb4OdeNtGAEo?=
 =?iso-8859-2?Q?r/I09Hx5zhk0u+LjVObLAOfmsJBgO9PHPowaDNuWDLhUoakGmUaFg99/nN?=
 =?iso-8859-2?Q?ZESC7OuvIqZgt2sZrq/Wv0/t1XgaouHDAzdqCn5bRUbIC4NUsxfUefVTXg?=
 =?iso-8859-2?Q?z5nr+zyD3i3ziu49MjMM5BP+ItpHeRSXUyiJkl2+j9IaH55UG5AhGNQX81?=
 =?iso-8859-2?Q?/lb525OuVpngqgwdjX5J2FL84aclFDIWrGiGfTI6nDFVuHO06G0gQnZh09?=
 =?iso-8859-2?Q?eJO/XtJ97DE9XSOFfKKDkebyVImV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5559.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?bEFw9n8mTzWQyS/vC3y3jnwCyu630qJGDNJ5yuUZiK8JRLHSp47bXCylDx?=
 =?iso-8859-2?Q?llkBEgm5d7ju5dXLl0qUXlVBFSnqdA+q9puEr2LiJBsGCRkxZqYxNNxHbr?=
 =?iso-8859-2?Q?ISk45elwkDzWTS362fWi5qA7ObcfMTgUowL7uzYvYzFBdkSLSVYPJyRJgH?=
 =?iso-8859-2?Q?c7YmBv6JsxPCEp0raMbb8kacU3uAvm5dH+Mh54B5ilLgo9D4dyVQ69llJm?=
 =?iso-8859-2?Q?w3chEKdt9EuQPm+W7bsLy7pJ2uqhCGR5oCAE/Iyyces3pnUDllt5BUqAbE?=
 =?iso-8859-2?Q?8TFDwfZqLP1LSCdqazHsdMt8TdrBnqyuq/Rt54c97h361JzFUR4Slt8210?=
 =?iso-8859-2?Q?qhmpBSUHNlu8RGyAaYRRAXf9ddFiyDLe8/CI0k9qZS/7s+x583gLYRxf+W?=
 =?iso-8859-2?Q?NVaC3gfT4zEojaOUXRlEVeZhJTEWgRiqOna4MyEg2BG4ciTg+4B/VE/r6n?=
 =?iso-8859-2?Q?mJy8UFQBUIrPIUX+GW4BNlH2E6CrdXcTKBJb7H9f9pQwdxL38/lEI1O8Hz?=
 =?iso-8859-2?Q?snQuu4SyxqMvkv9dFOvBmUjtOc/sNrP6X8xAFfSXwwJV1A0kQYdIhgFmDM?=
 =?iso-8859-2?Q?Ro6AZnUUYX94J1Z6F2DTu5//LDoe6bY2f9ifh0OLmfmaj/Lt9GJpY2KmIW?=
 =?iso-8859-2?Q?5wBsmJ8Agt+BoQw4mEAHXVBc8jWlC+671GlZRTKnlRqiUudYZ05v34UukJ?=
 =?iso-8859-2?Q?EaXgwBWylSpz5idA+2DiXTmsJJl76zqnoExKYtjblCLEhd+8v8ZN+BW8aQ?=
 =?iso-8859-2?Q?1rF1pHIVTnWVLmO+6pyKa5Yyl4b59L9Tcuvmfqnmkakbb3s5LDoWyMN013?=
 =?iso-8859-2?Q?ZsmpbqpbHwC0ZRPXXUfe4JEubj6SNVqxvC+MrW1Rgc+GrDAwJOTiDdTfxG?=
 =?iso-8859-2?Q?kt9wFTdSxt24MItFDo7K6cTe58AtlPhsULtXcES8fIOmMC+Bl2YPAiuX6i?=
 =?iso-8859-2?Q?3b9zH+H0OOdUqUjnq5IIH1cutu9XNXJw7tYfMmEUKB65MdAxR5Z70SpcxY?=
 =?iso-8859-2?Q?/5GEbhZYH88SfP6Kdf45E33DFSoeqnnRqwMGD5mHwL0Yq+A0wmvcSMUvwa?=
 =?iso-8859-2?Q?HWj478hEx4ecWeRQy3asXFfnrABuuSuKuIGIteyYcy6ld7tYopUssGmFqH?=
 =?iso-8859-2?Q?/tpGqj36yZNL+wuhZJPZNnJzB28DyuxDtwJignAm4+YE+I5Qws/ri+tMCM?=
 =?iso-8859-2?Q?1AV3lHTaBS5NcRqJduHabq8CdmeEiREV98SU9NribeaKNRdbxn/mgqZk1/?=
 =?iso-8859-2?Q?UIH2jiQoDBROVsVHGuBXe0xatgitEMWOObLwm6ID1sa4gJA0JUyEt490Ta?=
 =?iso-8859-2?Q?4smRBtUCXuyG8PC/2KedVPo2UdJ71Bh1TmZnhv2/rHXiAFqC0JhTuFd4ig?=
 =?iso-8859-2?Q?IV5YL7TztQKYUcFNxtXA9EWJ3UcfQuXq+dHr4UOjToJtOMDCmcG3o1HdGm?=
 =?iso-8859-2?Q?oBKJKznMRoRB65kkk66eQG9mauqsUHz0kuWrbox77B6/G4GUNjM2d9zf21?=
 =?iso-8859-2?Q?qgRWJkSaSKyKoGxkuZDaLz0EWORhnIQNMoEYCWyPGeeIv9u294s4vPAIan?=
 =?iso-8859-2?Q?3AQzCCLfZKzbgWcrjLCpqQRtwOQH78x0m/qQLEj/P73iQVRRSvUnjFuGIR?=
 =?iso-8859-2?Q?M11mm34k4OM10bliOZ+Zqhh+XAhjSTsdYCTaq+C29+XFVfsxt/an/DjA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f39bedc-e1fc-4567-5b89-08ddbd56f939
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 13:05:40.2332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNYSyyycjNNcUcy5S7BOLD0Puswl3rA1e4ZcJRiKq40SVD0YVinHj4hieGax0LBK4CfJJQeeD77OU1EAIO1HrLr4Ys4nji2GCO4Dke1UBSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4737

Hello Steve, hello Ryo,

> I think you may have found the main issue. That is the timer softirqd
> will pick up other softirqs that are pending. Yes it is a separate
> thread and will wake up to handle softirqs when the timer softirq needs
> to be handled but I don't see anything limiting it from handling other
> softirqs.

Thank you for confirming this. I am now leaning more towards trying
even more separation, to achieve a state where, if handle_softirqs()
gets called in a context of an IRQ thread, it will only handle the
softirq raised by that thread, leaving the rest of pending softirqs
untouched.
I have an idea in mind, but before trying, I would like to understand
a bit more how the bitmask that holds the pending softirqs is protected
against races. There's this block of code in the handle_softirqs():

        // ...
        pending =3D local_softirq_pending();

        softirq_handle_begin();
        in_hardirq =3D lockdep_softirq_start();
        account_softirq_enter(current);

    restart:
        /* Reset the pending bitmask before enabling irqs */
        set_softirq_pending(0);

        local_irq_enable();
        // ...

Here, local_softirq_pending() and set_softirq_pending() access the same
bitmask, and AFAICT, the code isn't surrounded by any lock or critical
section. It is true that (hard)IRQs are disabled at that point, but to
my knowledge, preemption is not. If all that is true, then a softirq
can be set pending in the meantime and can get "lost" by the
set_softirq_pending(0). I find it very unlikely that such a mistake
would be there, so I'm probably wrong here. Could anyone please tell me
what am I missing?

> I tried to come up with an idea isolating (hr)timer softirq from the
> rest. Would be nice to get a comment!

Thank you for comming up with the suggestion. There will be people who
are more entitled to review this than me, but I will try to comment on
what I see.
 - Your suggestion will not only modify the behavior when called in
   the context of the timer thread, it will apply anytime it's called
   outside of the ksoftirqd (including IRQ threads).
 - IMHO it would be nicer to signify the fact it's called from the
   timer thread with a function argument, similarly to the ksirqd one
 - I would avoid reordering the softirqs and instead of re-raising
   them in the loop, I would suggest to only clear the timer related
   bits in the place where is currently the set_softirq_pending(0).
 - Your restart logic would mean restart never happens with PREEMPT_RT,
   including when already running in the ksoftirqd. I'm not sure if
   that's desired.

Overall, as written at the beginning, I'm now at a point where I'm not
sure if the isolation of the timer softirqs will solve the whole
problem we have - it may still happen that multiple pending softirqs
will be handled in the context of an arbitrary IRQ thread. And trying
to completely avoid the execution in that context (leaving it only to a
low-prio ksoftirqd) doesn't look like a good idea either, as ksoftirqd
could get starved out on heavily loaded systems.

Best regards
Jindra
________________________________
Eaton Elektrotechnika s.r.o. ~ S=EDdlo spole=E8nosti, jak je zaps=E1no v re=
jst=F8=EDku: Kom=E1rovsk=E1 2406, Praha 9 - Horn=ED Po=E8ernice, 193 00, =
=C8esk=E1 Republika ~ Jm=E9no, m=EDsto, kde byla spole=E8nost zaregistrov=
=E1na: Praha ~ Identifika=E8n=ED =E8=EDslo (I=C8O): 498 11 894
________________________________
