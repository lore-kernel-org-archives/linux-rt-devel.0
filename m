Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C391D54CF
	for <linux-rt-devel@lists.linux.dev>; Sat, 22 Mar 2025 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742631856; cv=none; b=XfmN+cKrSCuAkCR9+8RgDXl6Kl1UEw3zztHLrJbgE4Nr8/UdmP1ST2elL2L/RAcd8SfUwxcuRSD2KPBsnJeG/zvNp3cD0cHEf/Dw4NhAL0QYT8+a/Z5w4ZsVGxHN0zgIHLAYhyBGFQDO7NyT3tRh5D7USRldGd5qIQaZhV1RYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742631856; c=relaxed/simple;
	bh=QmLK7E6LjzoFcr9A36fhxaE0X4NXRh1U31tLEUsyrqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9EX+lLf9Fabpl2BB2K7BYuvxPiFybKdmE2DOB2OYuFIdoK26lh6eqAFkcTD4AdOQFbSVLkHj9l7BvIj01inx1g/RTjcvkNSJu2eo38i6R1jUpAQcvQXdtr8vFOszaMvcwiBA50OP5oV71xqwf15gSWavdUfCzTfqjJrN/T7QW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0540f2dc06f711f0a216b1d71e6e1362-20250322
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:088af14f-fe15-4cdc-901c-0b6ec7d6250e,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:33e42e5cd915982f0189e228a26dcbe8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0|50,EDM:5,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 50,UGT
X-CID-BAS: 50,UGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0540f2dc06f711f0a216b1d71e6e1362-20250322
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <cuiguoqi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 19815541; Sat, 22 Mar 2025 16:24:06 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 24249E008902;
	Sat, 22 Mar 2025 16:24:06 +0800 (CST)
X-ns-mid: postfix-67DE73A6-38861
Received: from localhost.localdomain (unknown [10.41.103.97])
	by mail.kylinos.cn (NSMail) with ESMTPA id 857C3E008901;
	Sat, 22 Mar 2025 16:24:04 +0800 (CST)
From: cuiguoqi <cuiguoqi@kylinos.cn>
To: tglx@linutronix.de
Cc: anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	cuiguoqi@kylinos.cn,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org
Subject: Re: [PATCH] hrtimer: Fix the incorrect initialization of timer->is_hard
Date: Sat, 22 Mar 2025 16:24:03 +0800
Message-Id: <20250322082403.3126947-1-cuiguoqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <874izm2v02.ffs@tglx>
References: <874izm2v02.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi tglx,
=20
First of all, I'd like to thank you for your reply and for pointing out t=
he email issue.=20

As you've accurately noted, when PREEMPT_RT is disabled, it introduces a =
certain
degree of ambiguity for kernel developers. So far, no malfunctions have b=
een
observed as a direct consequence of this.
=20
This issue came to light during kernel development when using the is_hard=
 flag,=20
where the expected logic was not achieved.Naturally, we opted for the mor=
e reliable=20
is_soft flag to address the situation.
=20
Consequently, when PREEMPT_RT is disabled, there is a potential risk if d=
evelopers
choose to use the is_hard flag. I firmly believe this risk should not be =
overlooked.

I concur with your analysis that one of these flags is redundant. In fact=
,
it might be possible to consolidate them based on the overall requirement=
s.=20
=20
Thanks.
=20

Cui Guoqi
