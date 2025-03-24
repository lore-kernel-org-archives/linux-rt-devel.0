Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE338DE9
	for <linux-rt-devel@lists.linux.dev>; Mon, 24 Mar 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822182; cv=none; b=RZ3mC+4Gtf/ZlCcWMhimOlCLMtiuE4IfRq2OiiytWV5uIaWCt0ds8/OpeKQ72k1fTAGfJ7fIKQYUFHMpILxTfRnJEK+93J9eghYkfQtqJ3l+DruSR0wyORE1/xIrxG8vI9Nnp4kg93+n3vR1K6Yyg2uf2JOugUXaaAlU2AXVCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822182; c=relaxed/simple;
	bh=zWa3147KsrZ6whgHHaGYdYSkNDy6PyAY3OS5VX58pdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibRaPsI0lfBffycecgvX2Uf9Vliqm1alM/Gx18CR8jq7Gb0xEhj2XfpOaK8GCOVbvrpgxOZC5jG/gLTkBwvMC2RdIc0/5TDCJttc8Km9pL5pl6tm0nAnH59k4M0ZWZBU8ItTdynyxeUHXNw2HWSmhuo/FmEQ3fd5V3XkTvyECeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2432e8dc08b211f0a216b1d71e6e1362-20250324
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0578c1db-ea39-4a13-877f-ddac18d94548,IP:0,U
	RL:0,TC:0,Content:12,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:6493067,CLOUDID:92416e222b85cdef289d1b3157898085,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|8|50,ED
	M:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2432e8dc08b211f0a216b1d71e6e1362-20250324
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <cuiguoqi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1019829283; Mon, 24 Mar 2025 21:16:05 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1E024E008902;
	Mon, 24 Mar 2025 21:16:05 +0800 (CST)
X-ns-mid: postfix-67E15B14-9837241
Received: from localhost.localdomain (unknown [10.41.103.97])
	by mail.kylinos.cn (NSMail) with ESMTPA id 50DADE008901;
	Mon, 24 Mar 2025 21:15:58 +0800 (CST)
From: cuiguoqi <cuiguoqi@kylinos.cn>
To: bigeasy@linutronix.de
Cc: anna-maria@linutronix.de,
	clrkwllms@kernel.org,
	cuiguoqi@kylinos.cn,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	guoqi0226@163.com
Subject: Re: [PATCH] hrtimer: Fix the incorrect initialization of timer->is_hard
Date: Mon, 24 Mar 2025 21:15:58 +0800
Message-Id: <20250324131558.1633796-1-cuiguoqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324084944.z1J0Kf8c@linutronix.de>
References: <20250324084944.z1J0Kf8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here,it is not set but referenced. When !PREEMPT, is_hard does not match
the actual situation.In the original logic, the actual mode selection is=20
mainly based on softtimer.

When the HARD/SOFT mode is not explicitly configured, the following logic=
=20
is used to select the hard/soft mode:

> bool softtimer =3D !!(mode & HRTIMER_MODE_SOFT); //PREEMPT_RT:flase/!PR=
EEMPT_RT: flase
> if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD))
	softtimer =3D true;                        //PREEMPT_RT:true =20
> base =3D softtimer ? HRTIMER_MAX_CLOCK_BASES/2:0;//PREEMPT_RT:soft mode=
/!PREEMPT_RT: hard mode
> base +=3D hrtimer_clockid_to_base(clock_id);
> timer->base =3D &cpu_base->clock_base[base];
> timer->is_soft =3D softtimer;                   //PREEMPT_RT:true /!PRE=
EMPT_RT: false
- timer->is_hard =3D !!(mode & HRTIMER_MODE_HARD);//PREEMPT_RT:false/!PRE=
EMPT_RT: false
+ timer->is_hard =3D !softtimer;                  //PREEMPT_RT:false/!PRE=
EMPT_RT: true=20

Thus, under !PREEMPT, the distinction in is_hard is clear.
while it does not affect the logic of the hrtimer_start_range_ns:=20
>	if (!IS_ENABLED(CONFIG_PREEMPT_RT))            =20
>		WARN_ON_ONCE(!(mode & HRTIMER_MODE_SOFT) ^ !timer->is_soft);
>	else
>		WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard);

