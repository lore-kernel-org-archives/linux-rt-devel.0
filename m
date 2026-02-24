Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77803A63E6
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Feb 2026 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947911; cv=none; b=PGaxD3JQmN4SOgTAeyWv9E+QaT23RauszLWSsDYpuM01dvWWjOuUAXiBdNCEaRtAFFRLX8Yf9WNwYrr5/u8X7msUaj0yPR2gBD8Yd0rcJQs1rYvY9b29g/wtcIWTB+xynBYZlhzbVPTOHZW9ASjmVlW0t1JBr7kC+NFX/nz3zaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947911; c=relaxed/simple;
	bh=AJrbIOoq1vjPbapzMr+JTKVtA8qQq/8p6N1SDz2HFtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoOce6LugxXzTkN1JPOtvPzER4gBiHgnaKVSr4gpPIpMPI0JXstGjQn4G0Irytz3KJI4yM/glMJTE5g/1SRinsBPVJjQZb1JtkqQ1bv2ypEO7jMABswsM9fBxq+dfXNQb+D4U2bnGEIawEIeU2DX3IL4y8fmLL5WmBazZy+983s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lSmatnTm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lb8EpwQ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lSmatnTm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lb8EpwQ/"
Date: Tue, 24 Feb 2026 16:45:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771947909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE+Sz0997DVAF2XaMqoc2Pl/Cw0rojI6cG/+zzIDem8=;
	b=lSmatnTmuqMFA+PVqIMP8zuDiuTcFjN6iOazWrdvpN0HqwQK6uCdS0f819r8bcwlCx9NoP
	IQfFNLskIn+oww+FCvTBp/z2xLCJbr2PN+f1Qbugk4v05cDAJBcVhRwT3K+EAHhVUIrVRi
	JbIGffhwLigUkJyzCAPc8KaLV72z6nQQExiG7P+zVXcxygLTdQblBSGG2D5SdmTYFP7fpe
	fqV4MWWNX7R1draVLc9BKlGl3L4aKFCKKugF8ottmutEuE6aOPGcMwH5K8z1FPHVhxT0hf
	lWtFODG5MhoAkM70uoWGCl7oQGLsW6xVSuzcCjGFUMFizWpwCKrBTb9xGX5SJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771947909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE+Sz0997DVAF2XaMqoc2Pl/Cw0rojI6cG/+zzIDem8=;
	b=lb8EpwQ/mlKTm/tLgD8uzAl/D9ILTYhn5JnNh0LHdkAxeGNoGlQT4LED8hSrug8bBupN5r
	MgDzqk92F0NehfCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, dschatzberg@meta.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260224154507.4iZ85Uas@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20260219164648.3014-1-spasswolf@web.de>
 <aZd4YCNTAHZNpTfh@mozart.vkv.me>
 <594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>

On 2026-02-20 00:10:41 [+0100], Bert Karwatzki wrote:
>  BUG: sleeping function called from invalid context at kernel/printk/prin=
tk.c:3377
>  in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 16, name: pr/lega=
cy
=E2=80=A6
>   <TASK>
>   dump_stack_lvl+0x4b/0x70
>   __might_resched.cold+0xaf/0xbd
>   console_conditional_schedule+0x26/0x30
=E2=80=A6
This is addressed by commit 8e9bf8b9e8c0a ("printk, vt, fbcon: Remove
console_conditional_schedule()")

Sebastian
