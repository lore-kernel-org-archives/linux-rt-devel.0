Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299132;
	b=bLm09PZf3w+Ua0Inxt8tuxEWd4SoCwy2kYj9Y+sdB1rdXdg4x6tRauuHyMOO2kg7A6HU
	 8uE+xOPYQXvzSNn9zFWrzwEjOwgEyQsrjVM6UBILKBYqh6kanvuX1uxlqwAs+vWDAI8Sn
	 jCQSzDQjFNsz0G1UXEk3J0C+Bk4biL7lVkqcnDV8G4TslPf6r5xer7Z7zpM6lEfcF6oY1
	 +dT9ycrxuI6GgGBNuRdLIeISHhJtY+SMdejHAtQZUklTZZPop+Mo8hvMQjxSCtquZ9Xk/
	 put976kXSZSMgzBF4r6etsViawSyp6gwHS1XXoa+b65tACh8g2CloiZvka5HqeEBifw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299132;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-kuka-no-automatic-footer:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mw5JUe7A7NkeFD4B1Y8yMH0Z08UgM3nvhLtC6t3gBfQ=;
	b=ZNpINJtdYAUWNPdPvP4nlrByaD+M+b15LS6c2i2zM4rCEnOcOC0yv+M847NrLbNm0g/1
	 WnPhXaObvgiSPfyXR/bOYnKo9fHDJXpBCoTQVWhzcNNn1t6eE74AmSAESqHkWSc6cU6hH
	 UuN2Gf6nKC1XjXt5AV/5Bbn3UifPqnUfV74i+KCJZoZYXjYyxYe/SKLqmKsznYbaVB5zh
	 9aVxZlCMJgFEdO12KtyxkBwsKprsml/WVftVIEGG9rYAE6SRvs2h4A28c1uoSZtycaLqZ
	 7uE9bbiYt62WksGYTDbQf5jY32jPNu17o1LTjfflS1B+Xzd3KmQBDSsvlYjHYQF0aVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuka.com;
	spf=pass smtp.mailfrom=kuka.com;
	dkim=pass header.d=kuka.com header.i=@kuka.com header.a=rsa-sha256 header.s=selector2 header.b=msU4Er1P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.13
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B874A60A6F65
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 08:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B874A60A6F65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kuka.com header.i=@kuka.com header.a=rsa-sha256 header.s=selector2 header.b=msU4Er1P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsuzcSQQq282D2nHZzNaEOYKnHJ+5M9RWfrh/6rLp4EMfkjaUt96GMr6tGyNx3uHX3snrBvgC5ob4/ts+uoOElcxR69SOe0iPjx8N/59UUaY09mZxXFUCnDkEWZ9KNhrRMXijgJ7MpdKgK6NsmqxohYaqp5FeOgM4D8f5mAGk9xHnu29f8LypkyUIYUlSeqeg7li8aPcZTBnemQ8PS9/7KUo3b/AYVj8TxMZS1JsnzKJlwHPA63wvXv2ZovIzTKv570WSBtWPcQ73krjAE7hjmbMMGMZ32Qds3slUo1wsVhn9tixUXrBo9idk8oP2GVBLbmY0jb9/U191u1XZpLPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw5JUe7A7NkeFD4B1Y8yMH0Z08UgM3nvhLtC6t3gBfQ=;
 b=G0xtrEhqLtYZYabV6hmZ3kGV2GIRdMBIh46ddtNL2Y4UrsNSvpBRLGvjeNddVID1l72SGCVerWVyrC1SJ2oquPwSJJhiauZCYTUMP0sj5smUAQrq/JQvkWJdxrTf7RJ9mkKAgqySxQ8m0qgVQMUi9+ri/eF4dTDlYWT54JDNA/CsHqWZSEPuGHjpGmtjGeGdQoG6wXNGgnobeyV0CVU1B5ZCCJqUjfavc3V2OwlAI0rl3cAUzSz5QXmPPtmMkB6w5MpMsdGA4aROu4S+SChL5HiJ7CiAM3/STqdGHo6FtEuoJNGEBbMd8zQykHzhrwZTnfeAPfJUJMAE8x9Z3j3LuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw5JUe7A7NkeFD4B1Y8yMH0Z08UgM3nvhLtC6t3gBfQ=;
 b=msU4Er1PAzL3jqqxPMULq+rrjVu7bXFuSOf/yurwthGoUSZtUG0OPv4PNINy92VfKKOohLyuEmCVB02MGR4/+J9YIZ7lkM/ex264H2KhI+oiJL/3SdbPQJSPOqKT5GVdCGF+clnbj42AzkPjObHG+k5h/DfjPZLuM3GuJ1R3W7VXDtn/HZMm8Eqm6fTQ+NpBpES0sCHZBUJmmpNQVBXc78dMrGsc6BJpTuQm9kRwOXX7dYwqvRdEVtOEoP1s6cZqosU8FVWfOr6PXHt+DS4MLCVHLJi8cjX50ic58QgudDQfjdJ9QRuEUOokzv6F6py/PpwjevXmC1Sl7xhJVAaFkA==
Received: from PAXPR01MB8824.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:224::14) by AM7PR01MB6995.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:1b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 08:25:28 +0000
Received: from PAXPR01MB8824.eurprd01.prod.exchangelabs.com
 ([fe80::25fe:77c3:6eaa:48b4]) by PAXPR01MB8824.eurprd01.prod.exchangelabs.com
 ([fe80::25fe:77c3:6eaa:48b4%6]) with mapi id 15.21.0592.009; Tue, 10 Nov 2026
 08:25:28 +0000
From: Alexander Krabler <Alexander.Krabler@kuka.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@igalia.com>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	=?iso-8859-1?Q?Tobias_Sch=FClein?= <Tobias.Schuelein@kuka.com>
Subject: [BUG] futex(FUTEX_LOCK_PI2): timed out PI waiter keeps owner boosted
 until it gets the CPU
Thread-Topic: [BUG] futex(FUTEX_LOCK_PI2): timed out PI waiter keeps owner
 boosted until it gets the CPU
Thread-Index: AQHdcO0K8CHM4VXnokKf90szhrlw7Q==
Date: Tue, 10 Nov 2026 08:25:28 +0000
Message-ID:
 <PAXPR01MB882495A65FEC263204092D0A82722@PAXPR01MB8824.eurprd01.prod.exchangelabs.com>
Accept-Language: de-DE, en-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kuka-no-automatic-footer: true
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR01MB8824:EE_|AM7PR01MB6995:EE_
x-ms-office365-filtering-correlation-id: c0f02154-c0fb-45eb-0ede-08df3f042d36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|38070700021|260925021311599003|260925021911599003|260925022911599003|11063799006|56012099006|261022105027099003|261022075727099003|261021135927099003|261021121427099003|261026121527099003|10067099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003;
x-microsoft-antispam-message-info:
 7akoCYiV/xnBkzoy0B44jZZXqF/Y2wr+sLWE1xpiQDnw3Phz0zr6Z8rkpWKWjjw357YZofsh1kEc7qciPR5E9bi5fsesuHDLtHzIDtmmVgHA/5rk0YVvypHjOUXbvfkFQe5GbYYSEKiv6ITkxw+lxT9nUvBfe1NRTrzvDBAcA+2b8L2hgRXzOjiuQWQIJ6XCp85vItjO/uUnhWAgazYEnpr/P4kDXtco9nVGvq/qZIsj8CTd9Uqufe1Mx3aOQwFNoks5Je7Q0IpFamsxowqz42NQFVair4JK27nLG1H9NnOVtN1IzTry30hzBcyR3xBjMF6KjFaWQcpKX20TLxXKsL5de7V0g6Y7yiz1a5AfbhilXPTnWRb7/xxw2xmk79pg1c+sEkWlTue7GupaDrGeeAS0p2y5V/wup2ooXvAlIOnXw6l5qZjHETRGVeN0uWCeEtMyJ/4oY0EXh6wr0DpIkhvZTuC5sFzzzuxfUz7HvRdWyiXcx8coWiaHu70LcUZ2xpd0LTBxylKcDnp66+DdMe/hMcV+wtrf4WtIRPIujSqAE02Az07xXOUiOmHfLh9+XypiVsyVutSQnfFT6UUqA/AYWUIYM9Mcgh4Jw6UuFXRHmLdaVtPDbYO8trarYh1q8lEISVC4Pt4k0E0BTWzxzM9GWrCrFZh1FLVNbTfJjYxgRzhUfHeF1PrPYlyi1UfmnErdIEg8EW7IMeFmCsuTMzsBzy5vGJZ2pfvo7mchRrk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR01MB8824.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(38070700021)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021135927099003)(261021121427099003)(261026121527099003)(10067099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?o6bGeIMoZBFi+9u6kifnrWzUlWWF6FZ+n1e7y+MNPg2JOC464vvOgbs8Ct?=
 =?iso-8859-1?Q?t968D3m9nDmX6UD0bN77zCUPsAuNQOnm+buv4hQs16Y+Cx0UFWB/DSIlLs?=
 =?iso-8859-1?Q?sWaL04pcPVqx3ieQnVV1/e+E1cP0pyVcuWlE7cU7NONX2KFDQ0LNySN7xs?=
 =?iso-8859-1?Q?Sg2epo1HbX6xDjuKqF+IeHIET8kfbgb5MXXdak/L0Qi9J3lsaYLbRGmNbD?=
 =?iso-8859-1?Q?zlvi7YpHEIFjybNdKFkTkOzTihwP2A5sopQRwmT+jTKI2Xpsp/1OVXv/tH?=
 =?iso-8859-1?Q?nbilp2ZvFd09ap1/EKTLjpZ6roBsdm6AIHNRfm0h/BfQJ9xT8oPBy9grav?=
 =?iso-8859-1?Q?owG6NoONNw8ZegUKlv+tViTUqNb3cI5ckYRIsyvOGC37ZOKG5qz2nheMde?=
 =?iso-8859-1?Q?4obGzWe7XzGF77VvrJCUkAQVXkBMCvzfMnMn6f2OocOy1h5KzmqYOdJIkg?=
 =?iso-8859-1?Q?2wQImzqFLHDxkzPSFXp3FbX+jgdkNe5Hz+Z/3G8PS8ZAKhpeOGKO6MqDgO?=
 =?iso-8859-1?Q?utx8tkq2ysr60b7auIv/J9os7kDjNO/yjnKw6BKn+ipedQAXnpblOH1RW8?=
 =?iso-8859-1?Q?2PxvTZQbjimYWDrSAOwqnzTLtEigA9cYHioQ+bNEb3dCcugxXT5zPqrO9T?=
 =?iso-8859-1?Q?V3P9v44r4BLOuWd3S+N8YTgxxk9fM3yGSTOw73EusosV6bNQqMeDy7SLGB?=
 =?iso-8859-1?Q?zxrxJbx5tcS/OAm1GuPmXr6de740y0VL8aXWdJTLgF2EcDx6xPRgZiRBdp?=
 =?iso-8859-1?Q?tam6wCO4Qaq+WcFR5pFAp3WyIRc+DDIXQN2pY0mFjxkfcOjUoNxxbFPDOs?=
 =?iso-8859-1?Q?fnVFnOW6L/Rgj86eP0JoNvkgvIAlC/oBXeijtYAYbAVM+oEKVrDSGzMltn?=
 =?iso-8859-1?Q?sw4/2gQIYyP+e/h86gPeEj7vVj/cYTizuYQVw6+Lglmy17mFAFAne5eFds?=
 =?iso-8859-1?Q?z8r+Ubllhjr7uEk7NIE9rO2Tn6BnneSepSyz80pHq36qUDtOmCMxM+4WJ0?=
 =?iso-8859-1?Q?ACtrBgzKqMK7SzUVlB4SKVl1LYCZRhicT1Nsjdwhkvan1Sq5WTbE4VOLyB?=
 =?iso-8859-1?Q?pHTr6W2kmNAnu+7Rc06VbQV0EyuuCZrM2XslwY7SFnvho1lNRagstWm/rU?=
 =?iso-8859-1?Q?3vvo0XCJndG5aFlE+rO5WaZQAXAWhXNUMKbEslJGiWyc04DH/lKQDqRGT+?=
 =?iso-8859-1?Q?XMtKm63BrTx1rKLjN4B7K1gCVa8rPI6bHyonW5nqE0QxR97PEY/MOncVfh?=
 =?iso-8859-1?Q?ZKhf11ulAcVNUWro41irSAu+a5jFwRU4rAM3bys5S+vrffhZb2u0E/SM/g?=
 =?iso-8859-1?Q?FYA9nxk1AcnaF+7IfSF8O70/+cKpDRWVK0cQj4e53WpnYSf18qYB/u0yFD?=
 =?iso-8859-1?Q?u+OYyOHzYPk2HSNE/uGKx5vOd8Qyl4ISimUdhrEB2xBTyuf9u6Bu1G3+6L?=
 =?iso-8859-1?Q?+fHN90y4nL6lkLZaPz4T4Kh5lwyfYTTT6X9C7/g5Ao4QXFKLFWqnORZ56W?=
 =?iso-8859-1?Q?GQ2Nu/3lDhKFmgFrv7bvYX8K8Im1AeYE/9BT8JjU4Nh6Qf80tXNgv/2dWD?=
 =?iso-8859-1?Q?UeY8z6YpMayLcYawvzV5aIsaPklT1yX9+s94C6ookZ+b8uFZclNgf/n3HL?=
 =?iso-8859-1?Q?GwNwECYQTLXVvuw2M2oAZeeTH0Smbgf2vvo0MMcHCVjf7C2GPi0OtM1eF9?=
 =?iso-8859-1?Q?ZRNEQESEizc1RsEydvi5nGSPuowFQdLb3yMgA3nrBtyukyuOMp7iqSgteK?=
 =?iso-8859-1?Q?S+a7lsREYVQ9QbU7mdRVrUk+TtVAmQS9zmio1KHCWFFzhfFxts38Akn1Gc?=
 =?iso-8859-1?Q?1LF+9PKabA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR01MB8824.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f02154-c0fb-45eb-0ede-08df3f042d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:25:28.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETLPpSNpWwoN92YCQyVHMcKbIJ7SWd4+GIZOLS+pgoYpow6Y3GpG7rY8b5NKG9KphrMjUn/F5GPyEkkcHCs+tfEKUGG5U55S0NvoANd6wNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR01MB6995

Hello,=0A=
=0A=
when using PI futexes with timeout, priority inversion can happen,=0A=
as after the timeout the priority of the lock owner task is not=0A=
reset until the waiter gets scheduled.=0A=
=0A=
The priority of the lock owner seems to be only reset when either of:=0A=
* the lock owner unlocks the mutex (FUTEX_UNLOCK_PI).=0A=
* the waiter gets scheduled after the timeout=0A=
  and deboosts the lock owner actively.=0A=
=0A=
If both threads run on the same CPU, by chance or because actively=0A=
pinned to the same CPU, then the lock owner can prevent=0A=
the high priority task from running.=0A=
After the high priority task times out on waiting for the lock,=0A=
it runs only if the lock owner voluntarily relinquishes the CPU=0A=
or unlocks the mutex.=0A=
If it does not, it can prevent the high priority task from running=0A=
for an unbounded amount of time.=0A=
=0A=
Commit b40c927345a9 ("hrtimer: Use hrtimer_start_expires_user() for hrtimer=
 sleepers")=0A=
(since 7.2) changed the logic to avoid going through=0A=
the clock event device and wakeups, when the timeout already expired.=0A=
Before that change, you can observe the above behaviour=0A=
even when using already expired timeouts.=0A=
=0A=
The issue is fully reproducible.=0A=
The example uses two threads, pi_waiter and pi_owner.=0A=
Both tasks are pinned to the same CPU, and use SCHED_FIFO=0A=
with priority 2 (97) and 1 (98) respectively.=0A=
The PI futex is locked by pi_owner and never released.=0A=
pi_waiter tries to get the PI futex with a 1ms timeout.=0A=
As a consequence, pi_owner gets its priority boosted correctly=0A=
and gets scheduled.=0A=
=0A=
After the timeout, pi_waiter is woken up correctly.=0A=
However, pi_owner has its priority still inherited from pi_waiter and=0A=
prevents pi_waiter from running until it voluntarily gives up the CPU.=0A=
The priority boost of pi_owner is only reverted when pi_waiter finally=0A=
gets CPU time.=0A=
=0A=
Tested on 7.4-rc2 (7475ea8b) x86_64 and on 6.12 aarch64.=0A=
Observed on both PREEMPT_RT and PREEMPT_DYNAMIC.=0A=
The reproducer exits with status 1 on all tested kernels.=0A=
=0A=
------------------------ >8 ------------------------=0A=
/*=0A=
 * Run with CAP_SYS_NICE or RLIMIT_RTPRIO set to >=3D2.=0A=
 * A FUTEX_LOCK_PI2 waiter that times out should drop the PI boost of the=
=0A=
 * lock owner.=0A=
 * Exit code 0: boost dropped, 1: owner kept the boost, 2: setup error.=0A=
 */=0A=
=0A=
#define _GNU_SOURCE=0A=
#include <errno.h>=0A=
#include <linux/futex.h>=0A=
#include <pthread.h>=0A=
#include <sched.h>=0A=
#include <stdatomic.h>=0A=
#include <stdbool.h>=0A=
#include <stdint.h>=0A=
#include <stdio.h>=0A=
#include <stdlib.h>=0A=
#include <sys/syscall.h>=0A=
#include <time.h>=0A=
#include <unistd.h>=0A=
=0A=
#define NSEC_PER_SEC 1000000000LL=0A=
#define NSEC_PER_MSEC 1000000LL=0A=
=0A=
/* Our PI mutex (futex-based). */=0A=
static uint32_t ftx;=0A=
static atomic_bool lock_returned;=0A=
=0A=
static void die(const char *msg, int err)=0A=
{=0A=
        errno =3D err;=0A=
        perror(msg);=0A=
        exit(2);=0A=
}=0A=
=0A=
static int64_t now_ns(void)=0A=
{=0A=
        struct timespec ts;=0A=
        clock_gettime(CLOCK_MONOTONIC, &ts);=0A=
        return ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;=0A=
}=0A=
=0A=
static long futex_lock_pi2_1ms_timeout(uint32_t *uaddr)=0A=
{=0A=
        int64_t deadline =3D now_ns() + 1 * NSEC_PER_MSEC;=0A=
        struct timespec ts =3D {=0A=
            .tv_sec =3D deadline / NSEC_PER_SEC,=0A=
            .tv_nsec =3D deadline % NSEC_PER_SEC,=0A=
        };=0A=
        return syscall(SYS_futex, uaddr, FUTEX_LOCK_PI2, 0, &ts);=0A=
}=0A=
=0A=
static void busy_sleep_ms(long ms)=0A=
{=0A=
        int64_t start =3D now_ns();=0A=
        while (now_ns() - start < ms * NSEC_PER_MSEC)=0A=
                ;=0A=
}=0A=
=0A=
static void pin_to_cpu0(void)=0A=
{=0A=
        cpu_set_t set;=0A=
        int ret;=0A=
=0A=
        CPU_ZERO(&set);=0A=
        CPU_SET(0, &set);=0A=
        ret =3D pthread_setaffinity_np(pthread_self(), sizeof(set), &set);=
=0A=
        if (ret)=0A=
                die("pthread_setaffinity_np", ret);=0A=
}=0A=
=0A=
static void set_fifo_prio(int prio)=0A=
{=0A=
        struct sched_param param =3D {.sched_priority =3D prio};=0A=
        if (sched_setscheduler(0, SCHED_FIFO, &param))=0A=
                die("sched_setscheduler", errno);=0A=
}=0A=
=0A=
static void *waiter_thread(void *arg)=0A=
{=0A=
        (void)arg;=0A=
        pthread_setname_np(pthread_self(), "pi_waiter");=0A=
=0A=
        if (futex_lock_pi2_1ms_timeout(&ftx) =3D=3D 0)=0A=
                die("FUTEX_LOCK_PI2 unexpectedly acquired the lock", 0);=0A=
        if (errno !=3D ETIMEDOUT)=0A=
                die("FUTEX_LOCK_PI2 did not time out", errno);=0A=
=0A=
        /*=0A=
         * After the timeout expired, the owner must have been deboosted,=
=0A=
         * so we preempt it and get here while the owner is still busy loop=
ing.=0A=
         */=0A=
        atomic_store(&lock_returned, true);=0A=
        return NULL;=0A=
}=0A=
=0A=
int main(void)=0A=
{=0A=
        pthread_t thd;=0A=
        bool ok;=0A=
        int ret;=0A=
=0A=
        pthread_setname_np(pthread_self(), "pi_owner");=0A=
=0A=
        /* Uncontended PI futex. Acquire from user space, never released. *=
/=0A=
        ftx =3D gettid();=0A=
=0A=
        /* Pin both threads to the same CPU. */=0A=
        pin_to_cpu0();=0A=
=0A=
        /* Use realtime scheduling. Inherited by waiter. */=0A=
        set_fifo_prio(2);=0A=
=0A=
        ret =3D pthread_create(&thd, NULL, waiter_thread, NULL);=0A=
        if (ret)=0A=
                die("pthread_create", ret);=0A=
=0A=
        /*=0A=
         * Reduce our own priority. Makes sure the other thread can run=0A=
         * and attempt to acquire the mutex (boost us back to 2).=0A=
         */=0A=
        set_fifo_prio(1);=0A=
=0A=
        busy_sleep_ms(10);=0A=
=0A=
        /*=0A=
         * Must be read before joining, while we still hog the CPU.=0A=
         * If the flag is unset, we did keep our priority boost=0A=
         * (and therefore were not preempted),=0A=
         * although nobody waits on the PI futex anymore.=0A=
         */=0A=
        ok =3D atomic_load(&lock_returned);=0A=
=0A=
        pthread_join(thd, NULL);=0A=
        return !ok;=0A=
}=0A=
------------------------ >8 ------------------------=0A=
=0A=
Relevant ftrace events:=0A=
       pi_waiter-7339  [000] 67127.305214: sys_enter_futex:      uaddr: 0x5=
5e4dc9de08c, op: 0x0000000d, val: 0x00000000, utime: 0x7f3702911e00, uaddr2=
: 0x7f3702b48010, val3: 0x00000000=0A=
       pi_waiter-7339  [000] 67127.305218: hrtimer_setup:        hrtimer=3D=
0xffffd27f8f3f3b50 clockid=3DCLOCK_MONOTONIC mode=3D0x0=0A=
       pi_waiter-7339  [000] 67127.305228: sched_pi_setprio:     comm=3Dpi_=
owner pid=3D7338 oldprio=3D98 newprio=3D97=0A=
       pi_waiter-7339  [000] 67127.305231: hrtimer_start:        hrtimer=3D=
0xffffd27f8f3f3b50 function=3Dhrtimer_wakeup/0x0 expires=3D67127276392278 s=
oftexpires=3D67127276392278=0A=
       pi_waiter-7339  [000] 67127.305235: sched_switch:         pi_waiter:=
7339 [97] S =3D=3D> pi_owner:7338 [97]=0A=
...=0A=
        pi_owner-7338  [000] 67127.306216: hrtimer_expire_entry: hrtimer=3D=
0xffffd27f8f3f3b50 now=3D67127276396064 function=3Dhrtimer_wakeup/0x0=0A=
        pi_owner-7338  [000] 67127.306216: sched_waking:         comm=3Dpi_=
waiter pid=3D7339 prio=3D97 target_cpu=3D000=0A=
        pi_owner-7338  [000] 67127.306227: sched_wakeup:         pi_waiter:=
7339 [97] CPU:000=0A=
        pi_owner-7338  [000] 67127.306228: hrtimer_expire_exit:  hrtimer=3D=
0xffffd27f8f3f3b50=0A=
        pi_owner-7338  [000] 67127.306229: hrtimer_rearm:        next_event=
=3D67127277000000 deferred=3D1=0A=
...=0A=
... After here, pi_owner should drop back to its old prio (98).=0A=
... But it keeps its prio until it voluntarily gives up the CPU=0A=
... (pthread_join in the example).=0A=
...=0A=
        pi_owner-7338  [000] 67127.315249: sys_enter_futex:      op=3DFUTEX=
_WAIT_BITSET|FUTEX_CLOCK_REALTIME uaddr=3D0x7f3702912ce8 val=3D0x00000002 u=
time=3D0x00000000 val3=3D0xffffffff=0A=
        pi_owner-7338  [000] 67127.315272: sched_switch:         pi_owner:7=
338 [97] S =3D=3D> pi_waiter:7339 [97]=0A=
       pi_waiter-7339  [000] 67127.315279: sched_pi_setprio:     comm=3Dpi_=
owner pid=3D7338 oldprio=3D97 newprio=3D98=0A=
       pi_waiter-7339  [000] 67127.315284: sys_exit_futex:       0xffffffff=
ffffff92=0A=
=0A=
=0A=
The same issue happens with FUTEX_LOCK_PI, too.=0A=
Is this considered a bug? In the documentation,=0A=
I couldn't find anything that would explain the seen behaviour.=0A=
=0A=
Thanks,=0A=
Alexander=0A=
=0A=
-- =0A=
KUKA Deutschland GmbH=0A=
Board of Directors: Michael J=FCrgens (Chairman), Johan Naten, Hui Zhang=0A=
Registered Office: Augsburg HRB 14914=
