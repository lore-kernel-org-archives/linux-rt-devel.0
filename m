Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14A28D8DB
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201617; cv=none; b=b1gGzHuQAunG4T02/HyPiDMXdlvF2Aynw3BJpQXnWCm+pmoNhC1CTcbCA30WaWSX22rc/hy8wVVQJPPuNMOR6/t36rpmRmgGVlgRCx2PZIeJEKUElGRrHZDUkD4gRJXjljXKincI8lYRNO/V38DAEPulSSLvY+sjlMdOe4MuG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201617; c=relaxed/simple;
	bh=brs38N0RgE8yI96R3MEjOCyZ8mT5cAieKdXZAwbRBuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo6snYQaSuF/x7fPSaV5Tk/Hv5wknIwYv6bp+M/IFnVk46qPxd66Oke87KG3f7Z595vOXyUYXaQSAsE06shUAT05kXhFR7+PSV/ZBToA/pybRY9uv1MTtPK/+6dbsnOdYZVeUrnk1rzE/osxw4NbR6l5+sqUQoT5okloCng00NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JhoRRYKP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NrsQ/Yia; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JhoRRYKP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NrsQ/Yia"
Date: Fri, 27 Feb 2026 15:13:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772201613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FONUp5fIzUcqR36V5PNAb4lEPYY4bQDyvlXWYoDtvQY=;
	b=JhoRRYKPc7xIz8eqkzUMTqAXKoVAn0tGx5xVX127JukSFiknCvdki2aZp/rBXOXN9oAOMS
	QXZAMfTxfwRZU0gHPN9szvd9G33PGivSl9DpDyCxI4Yyd9tnOg6L3mmaXuwhjM80jvDnst
	oMgoBIpoZBgqwGNegVjsiNLTX17baepMq94TpDXqLKrcnE09CkBRAgzn0bQ1pqzWqdMtiz
	rKt5H3QYgio5MrMBgrb5hA9k+PifvkW151IyVE39EBl1LrS5kFuiWA6Pec8PRPcBsiEFBI
	wBmOmLlyKOrFiOKDuyR3csBJBsrPSSCNuSj0fJtR1eCRenT7sAfsZuyCy6sKRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772201613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FONUp5fIzUcqR36V5PNAb4lEPYY4bQDyvlXWYoDtvQY=;
	b=NrsQ/YiaYX7fv0iu5O9/N2HYbr2JMP/UTLgKggdGaBi0K+nS1ACXsu9+CeQ94bSR/pVW95
	SyFQLvHixmbm6LBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	calvin@wbinvd.org, dschatzberg@meta.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260227141332.74RtR9HK@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20260219164648.3014-1-spasswolf@web.de>
 <20260225154341.32AjXoVi@linutronix.de>
 <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
 <20260225165954.180aRkaV@linutronix.de>
 <20260225223135.vjfaFo0c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260225223135.vjfaFo0c@linutronix.de>

On 2026-02-25 23:31:36 [+0100], To Bert Karwatzki wrote:
=E2=80=A6
> Until the sched_switch, everything is the same. But then systemd-1828
> (the one with the cgroup_notify_populated event) seems to get impatient
> and sends a SIGTERM+SIGCONT. It gets the exit code, the
> cgroup_notify_populated event is there later and just once. The
> app.slice notify is missing. And the rmdir gets in much later.
=E2=80=A6

I so proud of myself. Bert, can you confirm that this works?

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5283,6 +5283,11 @@ static void *cgroup_procs_start(struct seq_file *s, =
loff_t *pos)
=20
 static int cgroup_procs_show(struct seq_file *s, void *v)
 {
+	struct task_struct *tsk =3D v;
+
+	if (READ_ONCE(tsk->__state) & TASK_DEAD)
+		return 0;
+
 	seq_printf(s, "%d\n", task_pid_vnr(v));
 	return 0;
 }
--=20
2.51.0

Sebastian
