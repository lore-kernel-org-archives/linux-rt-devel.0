Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED941DF965
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Mar 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521905; cv=none; b=CKJn3iQq9wxUQSCSkjFo4mDYxHLk8NLdeln8MZDFjY34iiBU7UdBB+KvFIRaTmxzJ5nWvv9lesz7Rh6MkwQmlTbzhFuOSP+x4/wPdAXWgnyQd8XJRh4E03LxEB2nHZVgLZUG/xJqe7AQBgIi+lI5uRJtObI7YJPUI82ds7I4BOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521905; c=relaxed/simple;
	bh=EtW8aCkCfxAc+jWDaWwOmvFv1BqCrugX08wxnKMwleg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bOd/ERAJ9EGri/hlIV0hZ1CQywU5d6DdgPydAawbgQy5XrIxUKjiUs1OvchhoyfphASS/pjIP8CwRmnrgrt7IakMHj0LIazfuk6KzkiMbH5BAc27ncoDuhxW8bqro+oFOEej14jWxv0FVJLism3IxoSDx0LuZv36wCXMHig/AGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 04a16ba005f711f0a216b1d71e6e1362-20250321
X-CID-CACHE: Type:Local,Time:202503210942+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:da1b6938-4f13-4a9f-8110-78c786bf36b7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:33cad0a8e0ce4eabaf9486cca15933d3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 04a16ba005f711f0a216b1d71e6e1362-20250321
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <cuiguoqi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1140434859; Fri, 21 Mar 2025 09:51:34 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D9754E008902;
	Fri, 21 Mar 2025 09:51:33 +0800 (CST)
X-ns-mid: postfix-67DCC625-369892305
Received: from localhost.localdomain (unknown [10.41.103.97])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5C637E008901;
	Fri, 21 Mar 2025 09:51:31 +0800 (CST)
From: cuiguoqi <cuiguoqi@kylinos.cn>
To: anna-maria@linutronix.de
Cc: frederic@kernel.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	cuiguoqi <cuiguoqi@kylinos.cn>
Subject: [PATCH] hrtimer: Fix the incorrect initialization of timer->is_hard
Date: Fri, 21 Mar 2025 09:51:28 +0800
Message-Id: <20250321015128.1393009-1-cuiguoqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When PREEMPT_RT is disabled,there is a possibility that
timer->is_hard will be incorrectly initialized.
When creating a high-resolution timer and setting the mode to
HRTIMER_MODE_ABS,the timer->is_hard will be incorrectly initialized.

Pseudocode logic:
1. mode
   >> HRTIMER_MODE_ABS	=3D 0x00

2. bool softtimer =3D !!(mode & HRTIMER_MODE_SOFT);	//!PREEMPT_RT
   base =3D softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;	//!PREEMPT_RT
   > softtimer =3D false=EF=BC=9B				//!PREEMPT_RT
   > base =3D 0;						//hard mode

3. timer->is_soft =3D softtimer;
   > timer->is_soft =3D flase;

4. timer->is_hard =3D !!(mode & HRTIMER_MODE_HARD);	!PREEMPT_RT
   >  timer->is_hard =3D flase;				//error
   >  Based on point 2, by default, the hard mode is selected.

Of course, if PREEMPT_RT is enabled, timer->is_hard is correctly set.
   bool softtimer =3D !!(mode & HRTIMER_MODE_SOFT);
   if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD))
	softtimer =3D true;
   timer->is_soft =3D softtimer;				//true
   timer->is_hard =3D !!(mode & HRTIMER_MODE_HARD);	//flase

Signed-off-by: cuiguoqi <cuiguoqi@kylinos.cn>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 80fe3749d2db..9d8defb1e9b1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1571,7 +1571,7 @@ static void __hrtimer_init(struct hrtimer *timer, c=
lockid_t clock_id,
 	base =3D softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base +=3D hrtimer_clockid_to_base(clock_id);
 	timer->is_soft =3D softtimer;
-	timer->is_hard =3D !!(mode & HRTIMER_MODE_HARD);
+	timer->is_hard =3D !softtimer;
 	timer->base =3D &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 }
--=20
2.25.1

