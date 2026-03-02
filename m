Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0085.outbound.protection.office365.us [23.103.209.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD432E73E
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.209.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772493979; cv=fail; b=fUGRc/AUlER2tTBJ+Xbl/mXboG3jX2tu9OgAw2wT4ReDJxqOULpkT75o8g8yXg4nMk/f1vCqoxJyZH2/16rW7is3YIoFmqhEhI7z25QtHuK/92u+2Fl+PGdyBkNYSCD6+BNwwRdY76K0Sk+qWSdorUVNll8cLs4ivcXp6S3qZns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772493979; c=relaxed/simple;
	bh=oCr6GegVwXYMGPRlhWZumZhHm+bslriZWlRqyj0z3IQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dcyZiqcJSeVQ7ZaNQKnl4m7rvKgopiZZAYDBB6cRs+SgBM30Tse5L97jNUe0ZSnUDCqeTOr5mG5DRZW9BMfFpFwSO7NGnkmYY1FnxbBsvvnrQHQJnyth8GUwulUxn5dpSlCSya2/adzRt3O+dvcmkxnujvgSApFHva2medsU9zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ga.com; spf=pass smtp.mailfrom=ga.com; dkim=pass (2048-bit key) header.d=ga.com header.i=@ga.com header.b=aBWjD6UH; arc=fail smtp.client-ip=23.103.209.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ga.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ga.com header.i=@ga.com header.b="aBWjD6UH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=r2PHl9Fxi2ZTLj7oxfg2krX1GNFI0U1OIqzlwaxoma+TyJ9KABAhew5fAa/8Qdv9BInM5ybF3PcQlWlwdlgqpHoI+PnvjEtPIs4whie/xX1bHrWyUh87BcwasvDeuRaNT56M2knD6SYZC/ora0epu2U/7Hkldfj/uyl9Lyen+ifA+zC1VsMl8vADawQOtlf7dNOxeGY4poNZdl9q/0DhsrL/m0UD/k7FpU6puNYhsVuoGQbsTL9Qp4jPDl+ZRlcRfWy2tluqM2NWx35Qhkrsld6EuISYAUCV8lMeaJxL3mwUPukDi720Y39UzTB/reeMiIvbsUgLleA2TvGtgxxAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smEF7XYMGoNbfdU2BLYdn/Yf9G2VQZDzU5JOx9Uv4SE=;
 b=ts3CtUPFIw/OfKYZtoveTkkWkC6RwvVswmQCsna3F76HVGARjWZYXrgVGqH8sN5y0W9m7UpBaODZRNAurmxnpmx60N7wvsNEmsUcSHtfqHOtHaRqdTyUJx0EXR6a3rBL3uTTOYV82RTh/FDZdOAnDzb2Ux4xyahW+x5ZxVLdOnm/URt++uGQIPMNG/KFdCAO7AWFo4wTCArGy6sNXgTsfZ5qez2R+c/WeG3KtfgAl+qxQc4Co7Pj67GuIlOOy69jD16G6mVaAoGrZ4vWqqNsyGcTVnjIN1wOV+ktFzs3vx3yND5iu0FTS1ZImsSwHmQICcOcOzegTsMsjZc0Sqbspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ga.com; dmarc=pass action=none header.from=ga.com; dkim=pass
 header.d=ga.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ga.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smEF7XYMGoNbfdU2BLYdn/Yf9G2VQZDzU5JOx9Uv4SE=;
 b=aBWjD6UH0LD5Pqn29MSVuEJ/SWXl96Q34VQDaytOTr3rcNbeo/KiOwmHHnw7BhteHDwKZNoG41ke9/qXVLUGN7Hvrt5f1ZZtxeGEGzCjPeNj3z2ty6yAWeZgbLl/YXVGrIIDAjq9XWLnHAEXjY7erdmXp5/qCy1s03ttgz/WgFguQMvhvDTONLbRTxpsyU07RzwvwsIfHChexFblI9Mjj28rffKBW+NylWluRfdWgTXBBUeuxxQDf1EYBK7D2UOYqkd6n2GXhn2h+6Mk8JurB71US1v/+eapT0f/B63vxCVFiQj2B6DowajGZ5i+O9AoEvpzeUpjzahe/zNXQGfX6w==
Received: from SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:429::17)
 by SA1P110MB2008.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 16:49:20 +0000
Received: from SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM
 ([fe80::6e97:4555:2019:b375]) by SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM
 ([fe80::6e97:4555:2019:b375%3]) with mapi id 15.20.9632.025; Mon, 2 Mar 2026
 16:49:19 +0000
From: "Soderlund, David" <David.Soderlund@ga.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Bert Karwatzki <spasswolf@web.de>, Clark Williams
	<clrkwllms@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: RE: -EXT-[PATCH net] net: Provide a PREEMPT_RT specific check for
 netdev_queue::_xmit_lock
Thread-Topic: -EXT-[PATCH net] net: Provide a PREEMPT_RT specific check for
 netdev_queue::_xmit_lock
Thread-Index: AQHcqmOxryFcHgEwzk66wXf5AsWaCLWbdBsw
Date: Mon, 2 Mar 2026 16:49:19 +0000
Message-ID:
 <SN5P110MB0848D42085BBED56246C59789F7EA@SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM>
References: <20260302162631.uGUyIqDT@linutronix.de>
In-Reply-To: <20260302162631.uGUyIqDT@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ga.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN5P110MB0848:EE_|SA1P110MB2008:EE_
x-ms-office365-filtering-correlation-id: 252fae21-a6cd-4ed1-50a0-08de787ba64a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 Lh+1mRDiceM2ylGyC7yjQ5sbprMQaYaPJjkWIZFb6iKV4JzEGclnE1dC0gAB+IwkM03mF6pll2MiLEmEH0PN+mwMMcSw5/ve4IqQZX62Ydnw/9VAt3+CmshIFKnNd2j8yQ9BJObTdxaXcU6Uwy6Kv9uW1b9VprufHeBsuHkMQ2KTOYoQ8U2DossV/fdBg5q1julkX8bVtw7FnrIazMLsOJKcF06RgazCaNLPF70ifQm2pXaqbaT7pAYXoUl+nH0YGV8R3WdIkKzOecowwUwAJxH459gN1x0zLf/ex/WWnHFb8ABxZIiQ37Vefr1HKvcMRBw0+FSQXFFSsTcxVSvfu3IIwhHiF9Hrq/kv1YiSX2eDqNE0gHiTj3ZA+8b+5j+YUJSOnx+jW3nCQ6gYI929/NUicFk3sd6PWH1ensuy3ngUovLBoFsMs1FKodaBxz9rT5mDP+mByKwpHESYTfem9NxvxrEGDf/e1Cu822gB52u3hyvBLJFRNcfW8kwM6L7FIm/GZgh/Y2icAnZ8iBiwRaeUsEqMp/9ildbbQcxqZTNBh8fGq7OaeDcuPonbe2kcmsNBeFvSzmkOoX7LmzGP1Zmzrmctle4SnYMLiPiij5t5HXmWkCvB4wJBWiYBiKl/VtHmajrZSWyZuPYvFluIapHKhh6oRwtcVOU3ZfzRm/BAhgpUuDER22bNSj9FPGug+WIp36RTSk2qrzGTEl13uCw8e/N7XmgSaFcRIYrWhW9/3REPKgBat6BDG9HS+pUMIDIEFEjQbKORNSKcPe3/RuPU817sxtpZrPLY+eMNzzM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ms944swEJxU9asWtgYocFO6d0tIB90yrzQ1nKI/qR8+dS7ULYfqElCgLNSjt?=
 =?us-ascii?Q?CqSRvgxw1sZUvwTwb+Eh574wzAri/HpJ9DzL8TTIfzVdEiovK7FSzEkrnpq2?=
 =?us-ascii?Q?AvOiH29/eEBqlXtVuulx7vYi+9agwWGkEOQvA8Sht2I2ofsuBoeLk/Znd+5M?=
 =?us-ascii?Q?B97K1fdsH7QLFEZuszMlAw1uz7CvdEk0mcQ9D8Zp4majHvnRo4565QroaGDi?=
 =?us-ascii?Q?c7dqis5AO/UVCl8N2naGDJsSjHOijsLGIYs4yr0lMKslPJsXqsfNvL9Cohbt?=
 =?us-ascii?Q?vyVLqypapsF8LXrImicv3swi2czHJiECMIDSH/qpqIcBmjNU6z0YSD2dCXB7?=
 =?us-ascii?Q?gymfp7kF5iRCPTX/Qypv8dGKgGXtBB30Y44LQKXFHSFNb49/QmMMp5vqS0al?=
 =?us-ascii?Q?efw0DE6DX0M94HEsgTWlpn1TFKmmYBdbQPq0ZT5tOfN50/2yAkHYzbUJOnnQ?=
 =?us-ascii?Q?kHNccgngh4wRVCd0f0iLSWkviXD1c8V1vqS8j3mn/6XqSph6NuA6oialvN2Y?=
 =?us-ascii?Q?neNI9YCQUr774pJ9h86cDsH1rvItuOVqpJdey/9SdfZMumphFRIXCKYy3KgA?=
 =?us-ascii?Q?P7GED1DFs20MhcsxOaolvi8MwVBZe8yD6xmQo615rllsl2qEuLa1xje/maLc?=
 =?us-ascii?Q?tfEP0r68OtiEBSwIjgiD5hZJNr4KHQPqpEfrLZgwRPKdvN96JVBTNpNVUU6R?=
 =?us-ascii?Q?85MDOPRnTDRu2ONJ1LrzL2H1WtBIhEqUs8Lh0uU5sCYnwv645FOEMNjGOjp/?=
 =?us-ascii?Q?0IsNgwwQeYB15KWm5rvgIq4uN3Tea4sgZ2wBlCWKPIS2dHL44gedAQxVJoxk?=
 =?us-ascii?Q?U22tbyYpKkhE34RlQKwmB9BwCJGwUPc192PK0RkKBrK+qOPceJrwm44qKhEE?=
 =?us-ascii?Q?VDKe78yH5XHsJrpOBWjl7Uhlp8TITYjbyG7gJSAlgXBLrPsgzZskNM5/EqAG?=
 =?us-ascii?Q?sF1rcE8H65BtKoWkyiMHQ8YmZ++K3cHree0AwRaQDMb0bZQfdnssA7N6/Qdc?=
 =?us-ascii?Q?q0oPW0s8jA0BcYHZaXUK5BRFJwNXpocxDJgw9Fhs3o2F3LRMnLcvd3pNOtQv?=
 =?us-ascii?Q?KZBBU+3+h8GrKu3H1LB6VIcy0fPvNGBgBKVSAVMZ5cjilPW3r5AhtHMnCGxt?=
 =?us-ascii?Q?13CZ+g3o1MfVqaXdmWlO1LMtUDu1WlqR7aBAYdWN1bN/egN3aeYveiOpHdh7?=
 =?us-ascii?Q?mEac4xxZ82AMQHjt/TMNQlgWvQ+akEZuEiAPvVGaBMeidddA/KYMxV6locjh?=
 =?us-ascii?Q?P+91B2CDDfAwPtOd3+4ip9mOQgDRn7pSHfoSZ1Ct4l3fVR2x+4s8kBsSRAYJ?=
 =?us-ascii?Q?MKfsBHCNkT8KpdgtGBWBY4FI6XUYoqNQ6Nr2ZocR8TX7mNkeLWuo3k413QHl?=
 =?us-ascii?Q?lgOGIbu75eoEysRJO5sziCCS1kwJIpQu88w4mYMREMXdG5ucGkrk2GYDeEXZ?=
 =?us-ascii?Q?tyb/o1qoFbmppOnTUtqt2wQny7GlW92lBBY/ueK2vnN4G5SqaSEQ65HUDJJe?=
 =?us-ascii?Q?NLBWjFKaEn9G824=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: ga.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN5P110MB0848.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 252fae21-a6cd-4ed1-50a0-08de787ba64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 16:49:19.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05e53887-e4b3-4595-87f7-3ae79f0e723e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB2008

Please remove from list
  Thanks,
     David


-----Original Message-----
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sent: Monday, March 2, 2026 9:27 AM
To: netdev@vger.kernel.org; linux-rt-devel@lists.linux.dev
Cc: David S. Miller <davem@davemloft.net>; Andrew Lunn <andrew+netdev@lunn.=
ch>; Bert Karwatzki <spasswolf@web.de>; Clark Williams <clrkwllms@kernel.or=
g>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; P=
aolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Steven Ros=
tedt <rostedt@goodmis.org>
Subject: -EXT-[PATCH net] net: Provide a PREEMPT_RT specific check for netd=
ev_queue::_xmit_lock

WARNING:  This message is from an external source.  Evaluate the message ca=
refully BEFORE clicking on links or opening attachments.

After acquiring netdev_queue::_xmit_lock the number of the CPU owning the l=
ock is recorded in netdev_queue::xmit_lock_owner. This works as long as the=
 BH context is not preemptible.

On PREEMPT_RT the softirq context is preemptible and without the softirq-lo=
ck it is possible to have multiple user in __dev_queue_xmit() submitting a =
skb on the same CPU. This is fine in general but this means also that the c=
urrent CPU is recorded as netdev_queue::xmit_lock_owner.
This in turn leads to the recursion alert and the skb is dropped.

Instead checking the for CPU number, that owns the lock, PREEMPT_RT can che=
ck if the lockowner matches the current task.

Add netif_tx_owned() which returns true if the current context owns the loc=
k by comparing the provided CPU number with the recorded number. This resem=
bles the current check by negating the condition (the current check returns=
 true if the lock is not owned).
On PREEMPT_RT use rt_mutex_owner() to return the lock owner and compare the=
 current task against it.
Use the new helper in __dev_queue_xmit() and netif_local_xmit_active() whic=
h provides a similar check.
Update comments regarding pairing READ_ONCE().

Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20260216134333.412332-1-spasswolf@web.d=
e
Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEM=
PT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h | 27 ++++++++++++++++++++++-----
 net/core/dev.c            |  5 +----
 net/core/netpoll.c        |  2 +-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h index d4=
e6e00bb90a7..67e25f6d15a47 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4711,7 +4711,7 @@ static inline u32 netif_msg_init(int debug_value, int=
 default_msg_enable_bits)  static inline void __netif_tx_lock(struct netdev=
_queue *txq, int cpu)  {
        spin_lock(&txq->_xmit_lock);
-       /* Pairs with READ_ONCE() in __dev_queue_xmit() */
+       /* Pairs with READ_ONCE() in netif_tx_owned() */
        WRITE_ONCE(txq->xmit_lock_owner, cpu);  }

@@ -4729,7 +4729,7 @@ static inline void __netif_tx_release(struct netdev_q=
ueue *txq)  static inline void __netif_tx_lock_bh(struct netdev_queue *txq)=
  {
        spin_lock_bh(&txq->_xmit_lock);
-       /* Pairs with READ_ONCE() in __dev_queue_xmit() */
+       /* Pairs with READ_ONCE() in netif_tx_owned() */
        WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());  }

@@ -4738,7 +4738,7 @@ static inline bool __netif_tx_trylock(struct netdev_q=
ueue *txq)
        bool ok =3D spin_trylock(&txq->_xmit_lock);

        if (likely(ok)) {
-               /* Pairs with READ_ONCE() in __dev_queue_xmit() */
+               /* Pairs with READ_ONCE() in netif_tx_owned() */
                WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
        }
        return ok;
@@ -4746,14 +4746,14 @@ static inline bool __netif_tx_trylock(struct netdev=
_queue *txq)

 static inline void __netif_tx_unlock(struct netdev_queue *txq)  {
-       /* Pairs with READ_ONCE() in __dev_queue_xmit() */
+       /* Pairs with READ_ONCE() in netif_tx_owned() */
        WRITE_ONCE(txq->xmit_lock_owner, -1);
        spin_unlock(&txq->_xmit_lock);
 }

 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)  {
-       /* Pairs with READ_ONCE() in __dev_queue_xmit() */
+       /* Pairs with READ_ONCE() in netif_tx_owned() */
        WRITE_ONCE(txq->xmit_lock_owner, -1);
        spin_unlock_bh(&txq->_xmit_lock);  } @@ -4846,6 +4846,23 @@ static =
inline void netif_tx_disable(struct net_device *dev)
        local_bh_enable();
 }

+#ifndef CONFIG_PREEMPT_RT
+static inline bool netif_tx_owned(struct netdev_queue *txq, unsigned
+int cpu) {
+       /* Other cpus might concurrently change txq->xmit_lock_owner
+        * to -1 or to their cpu id, but not to our id.
+        */
+       return READ_ONCE(txq->xmit_lock_owner) =3D=3D cpu; }
+
+#else
+static inline bool netif_tx_owned(struct netdev_queue *txq, unsigned
+int cpu) {
+       return rt_mutex_owner(&txq->_xmit_lock.lock) =3D=3D current; }
+
+#endif
+
 static inline void netif_addr_lock(struct net_device *dev)  {
        unsigned char nest_level =3D 0;
diff --git a/net/core/dev.c b/net/core/dev.c index c1a9f7fdcffa9..e9ca0b1fd=
7900 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4818,10 +4818,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net=
_device *sb_dev)
        if (dev->flags & IFF_UP) {
                int cpu =3D smp_processor_id(); /* ok because BHs are off *=
/

-               /* Other cpus might concurrently change txq->xmit_lock_owne=
r
-                * to -1 or to their cpu id, but not to our id.
-                */
-               if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
+               if (!netif_tx_owned(txq, cpu)) {
                        bool is_list =3D false;

                        if (dev_xmit_recursion()) diff --git a/net/core/net=
poll.c b/net/core/netpoll.c index a8558a52884f9..cd74beffd209c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -132,7 +132,7 @@ static int netif_local_xmit_active(struct net_device *d=
ev)
        for (i =3D 0; i < dev->num_tx_queues; i++) {
                struct netdev_queue *txq =3D netdev_get_tx_queue(dev, i);

-               if (READ_ONCE(txq->xmit_lock_owner) =3D=3D smp_processor_id=
())
+               if (netif_tx_owned(txq, smp_processor_id()))
                        return 1;
        }

--
2.53.0


