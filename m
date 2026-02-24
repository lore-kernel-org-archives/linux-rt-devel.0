Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A93A9D8D
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Feb 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953077; cv=none; b=eC1UGqftNBmnf1DTOVtWYEUrmY/Uob5FmzzHoN5n3M/DspTcwukk0lgOIg3JawCxixYhbixxAE/lVuDIHRkEE72Vd/hGX28b2CWWIfO+zsAUvsM86PineOwgCJc9dYw1vet0n4pZUnjX8y42fIi15CXQflHhagoVhWvKNb++RDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953077; c=relaxed/simple;
	bh=gO+Lx9HjqZpnNiiKW+Hlyj6WX3c6VdFNoQXXUdBGa+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC3Ytlwt3oKuVmT5Z1xGKA/oIZkLsZql72u1tC4+I6Ag3BMiGhr9VfMc133Bk+/vWaw3WMnexy5pFMQvt+RrtKFxVAxTMQ4cy2J2qbT5gYDu2u8WEK73x3IdGB0ExZgtSUotinm4ukrAOnjMp1eRm/X7J4jAK2Plvg5TsQuOuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJ75VcEh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/hPZlkFn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJ75VcEh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/hPZlkFn"
Date: Tue, 24 Feb 2026 18:11:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771953073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaBeNCGnAwK/uOBpj9eGnAkm9oRNHfuJ+7yyGWbKZTY=;
	b=pJ75VcEhi/SA0R9VgIJ38buRuPbxKLppk954+Sd8/427asaot4s8dNLyqRm5M+X37uXEXW
	SqXuWmqhMuS6EPFzDGLft7h5gjuar4iV79qlWa4Nri4tKzQfLEmNyZGofGfOnhb2cHyanT
	82gnM+B3Qtd2Vw7LjC0C8uYZluaDsF1mr2IQE8oHirwzsmcc+ZDckNfkIKigWzGvP9N4gv
	qWueZzQ6Rh6hdZWeaMhHJtU6lAbfsFUyOa/rUddJcsJSej61tSOVX8EiFSdNitdYZ7Ov7e
	XJgyeQ+Enh4gpx3eh7a+hrIFu0/GKV+Zc554iWEdjyIvUrwZRYMPWLYilJjEPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771953073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaBeNCGnAwK/uOBpj9eGnAkm9oRNHfuJ+7yyGWbKZTY=;
	b=/hPZlkFnpk8AAS66EcfyImSdrFNCPLEarHj1dzEVMuEiPb530/cn137+lM1P2q43D4sSlm
	Lh+XtxfioUbyZYBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ciunas Bennett <ciunas@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] sched: Further restrict the preemption modes
Message-ID: <20260224171111.pMPZGcan@linutronix.de>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>

On 2026-02-24 15:45:39 [+0000], Ciunas Bennett wrote:
> Monitoring the guest CPU run time shows that it drops from 16% with
> PREEMPT_FULL to 9% with PREEMPT_LAZY.
>=20
> The workload is dominated by voluntary preemption (schedule()), and
> PREEMPT_LAZY is, as far as I understand, mainly concerned with forced
> preemption.
> It is therefore not obvious why PREEMPT_LAZY has an impact here.

PREEMPT_FULL schedules immediately if there is a preemption request
either due to a wake up of a task, or because the time slice is used up
(while in kernel).
PREEMPT_LAZY delays the preemption request, caused by the scheduling
event, either until the task returns to userland or the next HZ tick.

The voluntary schedule() invocation shouldn't be effected by FULL-> LAZY
but I guess FULL scheduled more often after a wake up which is in
favour.

> Changing guest configuration to disable mergeable RX buffers:
>       <host mrg_rxbuf=3D"off"/>
>       had a clear effect on throughput:
>       PREEMPT_LAZY: throughput improved from 40=E2=80=AFGb/s =E2=86=92 60=
=E2=80=AFGb/s
>=20

Brings this the workload/ test to PREEMPT_FULL level?

Sebastian
