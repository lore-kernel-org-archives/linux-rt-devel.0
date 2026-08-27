Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF4241686
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864856; cv=none; b=n4Iql6q29BaMypQQCjGz9QPHMdavGZcw1Ke6hjcrhOWIGex1CNDST7dqGfXh7E/VMTJIriY7GxMx3vOoE0t66SIZq+v9pL/rKPtSnSQpDpoqmYBsutuW1vHBxbkPYgBfCCk5uT1KORrCuaIAg2PDN1LMlejZ6QsC6tbs10fJvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864856; c=relaxed/simple;
	bh=MVKR6Pzrh5/lF15W562Ofyk5fmn1OdffMASDTRdZFps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DWisYpJMuqrcdt2m6Jho3GfG85wMkNpvsaQbJn7zlnc1llsN56d+MMyd6G9odI4kDjlG5P1sOGGWuaHgiTYu2uOoXrUYbPVs4DNRfUkUCiw1KAWSk3VwZak0FCPTPiwqZswz09HEOcBV2Wlx8a0QBiTQHrvO2JnzXbBm1OAi8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=njWA3koQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="njWA3koQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787864830; x=1788469630; i=spasswolf@web.de;
	bh=nRFDhaUwXIpLuDk3iWQUwhzno7/oihih62AfZPsxbcQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=njWA3koQP/zz02RoVbXej5yrA00SHF5DAagJmrTejv5k/3hGy+WAZ+/afSXBd1ln
	 uqoL5FlyfQBKwDgCj51ESJe2XFSv8JylkjZXRWobNHcqS5SgnMvTrgBzBNPopVng7
	 Wp2cnQQFoRgqYxaqY1SVS+axoyw7HYBPtAc/4bj0su160bbIzpwXd5P7kC8sFpGhD
	 L8oPvoQwZdjpZIa2xPu5mq/aNhAFPicbqqqA2rIRtY29zyhJE5EjMCTf4fR1cM/oZ
	 ChnUKck/LLFoezq0p6wHfanYJbUMxE1oNOTFOn3hbKk6VXqL1/B7zGAZ1e+IAHtHY
	 B+YGzpFATvKrqpAanQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m9J-1x0WOU3AnL-00EZ3j; Thu, 27
 Aug 2026 23:07:09 +0200
Message-ID: <bd31938661f178abaa68d3958bacdc1ebb70ff5c.camel@web.de>
Subject: Re: [PATCH v7.2-rc6] drm/amd/display: fix usage of
 DC_FPU_{BEGIN,END} with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, Mikhail
 Gavrilov	 <mikhail.v.gavrilov@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>,  Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Thomas Gleixner	
 <tglx@linutronix.de>, spasswolf@web.de
Date: Thu, 27 Aug 2026 23:07:08 +0200
In-Reply-To: <20260827124931.ocQEF6MW@linutronix.de>
References: <202608061233.eufnR5Qm-lkp@intel.com>
	 <20260807124944.154232-1-spasswolf@web.de>
	 <20260827124931.ocQEF6MW@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FLlOinNoAtPvryHrUdhVjzwwbi6AJBeMaErejUpJnr3lgrmbPgN
 lsn7tFl6s8OyIke16QXKk3fvEIRW2wwBfg02FplE7yMNiNSt1yHVqQWkwvPsUfEBfe/dcgV
 mdI0cO8r8fLgl5xVB5AlB8fjKukQRJIPpEAWcLh7dagnsqYSkTjCfaimnNRhAl2c1U4Wgb9
 5UJVCWSUDbO1HcEWhxNjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1SueLRKDMEk=;EB7DoTz2zd9YmVPsxpY2n518BSp
 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
 d3of9SJQFTjTrqXbk2ZfvlatKCTPdlXy

Am Donnerstag, dem 27.08.2026 um 14:49 +0200 schrieb Sebastian Andrzej Sie=
wior:
> On 2026-08-07 14:49:42 [+0200], Bert Karwatzki wrote:
> > On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> > converted to rt_mutex. dc_create_plane_state() can be called while
> > inside an FPU-guarded region, resuling in "scheduling while atomic"
> > errors on PREEMPT_RT kernels.
> >  Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLE=
D().
> > Also fix the error path in dc_create_stream_for_sink().
> >=20
> > Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC =
- Part 1")
> > Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web=
.de/
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>=20
> Thank you Bert. Got this somewhere in the meantime?

No, this is seems to be stuck somewhere ...

>=20
> Could the FPU regions with disabled preemption be limited to where we
> have actually have FPU usage in way that you don't have to worry when it
> is needed to use DC_RUN_WITH_PREEMPTION_ENABLED() and when not? Also the
> dc_fpu_begin()/ end() can nest and if they do the usage of
> DC_RUN_WITH_PREEMPTION_ENABLED() is futile, isn't it?
>=20

I'm not very familiar with the amd display engine, and it's a lot of code,
but there I think there's some room for improvement, e.g. dml2_destroy():

dml2_destroy is called from dc_state_free() from within DC_FP_{START,END}(=
)
and then basically just calls vfree with DC_RUN_WITH_PREEMPTION_ENABLED().
(directly or through dml21_destroy()). Here both the DC_FP_*() tags and
DC_RUN_WITH_PREEMPTION_ENABLED() could be dropped I think (not tested, yet=
)

Regarding nesting DC_FP_*()s: When I was searching for the cause of the
kernel panics I monitored every DC_FP_{START,END}() with printk(), and I
don't think I encountered nesting (the logs are lost unfortunately)


> The first usage kernel_fpu_begin() saves the FPU state to the user task.
> kernel_fpu_end() does not restore it. Therefore the subsequent
> invocation of kernel_fpu_begin() is cheaper.
>=20
> Sebastian

Bert Karwatzki
