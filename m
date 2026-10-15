Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE531ED93
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028417; cv=none; b=hvg8MpmXw8oJul+8tJG6EkB5q70+iK5TUPP9lKEirmfb7TJOP22eFBZOkbM+E54Tpj9fR4SranKiY+p9xTpszb5Oe1LdgRxb9YbI6bnCdrTS5pqR9kFQykql2UcxB+vTSL4WDuDDvehtJLmT2Khy1fSVKDZR9uka+sIZfyQTVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028417; c=relaxed/simple;
	bh=H+v/gqnjWQ3O7ct/IIm0+uSIkR+hWzXeTbgrHmFdb/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqDYsFMkQagPcqG03h01Xolpi+p4/xFbNR5f+Jt7cQUS98I/mp6sAQiWWZ+p+Pt/Dy87m5OWLVYPVdiQeBOECi73TNcbatSx38i9OAbMJ7ftqIs5yZ8i5+GPmUItWqNuaQLFV36fio8TKEa8omxOFUwMFFxxjsaHkwJfMhW8l5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=PfT12lda; arc=none smtp.client-ip=115.124.28.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="PfT12lda"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792028407; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H+v/gqnjWQ3O7ct/IIm0+uSIkR+hWzXeTbgrHmFdb/0=;
	b=PfT12ldaoZmCUxV36k9Zzs2dQ7x4Ps8jKg8dTpDL1uy/DwcokoeKBIjcFJneeIuFNeksc7peXgl1aVGZUKm7T99AaPfVakalNfY2D3zunq8rWkI8XOdxhhafMjai60XINL7HvQrwiNPh9PFFerydIOtdh+ZgAVNyGFTNrj0vNY4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1178455|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.192236-0.0012412-0.806522;FP=12588089935714567190|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=wangqk1@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.je7cEbj_1792028406;
Received: from DESKTOP-EL1SUEF.xiaopeng.local(mailfrom:wangqk1@xiaopeng.com fp:SMTPD_---.je7cEbj_1792028406 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 09:40:06 +0800
From: wangqk1 <wangqk1@xiaopeng.com>
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	xiedl3@xiaopeng.com
Subject: Re: [RFC 1/1] sched/rt: Avoid RTO push to stopped CPUs during shutdown
Date: Thu, 15 Oct 2026 09:40:05 +0800
Message-ID: <20261015014005.8885-1-wangqk1@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013120302.GJ2009045@noisy.programming.kicks-ass.net>
References: <20261013120302.GJ2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 02:03:02PM +0200, Peter Zijlstra wrote:
> This is horrific; lets not do this. The bug really is at the place where
> you randomly and without warning take CPUs down. We're not adding random
> hacks for things like that.

Understood, thanks for the quick feedback. I am dropping this patch.

One note on the trigger: this was seen on the normal poweroff path, not
on panic or crash. On arm64, machine_power_off() calls smp_send_stop()
before do_kernel_power_off(), so every orderly shutdown stops secondary
CPUs without hotplug teardown, and a CPU still running the rto push
irq_work can then pick a stale rto_mask bit.

I agree the fix belongs in the path that takes the CPUs down, and that
path will need to account for the rto overload state. If I find a viable
way to do that, I will bring it up again. Happy to test or review
anything in that area.

Thanks,
wangqk1
