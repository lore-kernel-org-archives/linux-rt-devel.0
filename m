Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E85224B03
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 May 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330367; cv=none; b=qyp7Or2Xy+CyUlBAPyxUDoN8GVEMxkPjCLQnYk/7ZTBZ6vCxmyWFiWhEMLVTqfcBpvDqDWUGqbRhJFKRlwceTpIq1JiYPKmDDUuRWyPiz7sE9HM9N6YL1C5Nb1DFKhX7tsxYiAN8VRHv3f/qWTqh/SuBOPKAMjy06YWjomKTNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330367; c=relaxed/simple;
	bh=P+DfASsF3XOdpf/4HNVYMTWhPAtrOK/A6WxEF7tuA3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltNTiv+6A/S3pIADxxuaIEIAsbGk1JnzlU09cz6gqDV4usC4/TmyeRkYkZzy6xlFaijEqZl0Q3reUXzLoUZA6lpNmistNUiHXEIl2yM73zN2SpzQscDhgR9rTtCjKMWpASbyWmL7MXxWg0BTJqKSgRrMGtyznXeWx4gfMsLb6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=apapJ4XV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1PiazP4o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="apapJ4XV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1PiazP4o"
Date: Tue, 27 May 2025 09:19:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748330364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx2Br0+lTeAcRN8YNcVFOMcOAMoDdXFwrWxkaUxCT+w=;
	b=apapJ4XVpYwj8XJZoW/SOoqLeoRwK2YgBQdFYcNL3p5BrjoCK1e/CRLftGX1IlBVX5L9U2
	GkNZ0WlaKE3r7BDoo3n9vvvr1u/BtJCkgZUDV5rGEa9vwD7IEmtimSf0uo2RUqr+Uhc0y/
	fZZNyZEnSQxqR3TakWcWJ+8oZSDeVEssUoVZQJL2afYKVp2lFDwYHDSZCN0KnGUK1sE/NX
	4iRRnnLbb7AGX/GbkpUljIiHKX1vPCoB4Q1aZVetHJFs5ET0WwtyWw9eVq6rKcYaGdt6L+
	cqEG/vNQ/C3jtYo9pwQbMHIoEjvrMAJqq+tuf2/sianrdvrYTUqK/ELF/u/diw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748330364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx2Br0+lTeAcRN8YNcVFOMcOAMoDdXFwrWxkaUxCT+w=;
	b=1PiazP4oeQ/6sjAG2aDxu/GlxI2TxRITpjes5iQvzpLt6SJ3tij4tIwwHFp3cZ9lxgV68d
	vfsgeanGlj749dDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Tejun Heo <tj@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
Message-ID: <20250527071922.tMPqxpsB@linutronix.de>
References: <20250525224744.9640-1-spasswolf@web.de>
 <CAADnVQLv3aX0iOrkAZRgP2x8UAVvy7oYA8x0dUPn7B6FD-10-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAADnVQLv3aX0iOrkAZRgP2x8UAVvy7oYA8x0dUPn7B6FD-10-g@mail.gmail.com>

On 2025-05-25 18:32:28 [-0700], Alexei Starovoitov wrote:
> On Sun, May 25, 2025 at 3:48=E2=80=AFPM Bert Karwatzki <spasswolf@web.de>=
 wrote:
> >
> > [ T2916]  rtlock_slowlock_locked+0x635/0x1d00
> > [ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [ T2916]  ? lock_acquire+0xca/0x300
> > [ T2916]  rt_spin_lock+0x99/0x190
> > [ T2916]  task_get_cgroup1+0xe8/0x340
> > [ T2916]  bpf_task_get_cgroup1+0xe/0x20
>=20
> Known issue.
> Please trim your emails.

This is the trace thingy. Let me take a look.

Sebastian
