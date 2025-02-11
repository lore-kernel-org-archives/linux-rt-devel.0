Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC71FAC46;
	Tue, 11 Feb 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273660; cv=pass; b=fF6YIFjQGdc6LQ9zbR4ChDFNaIxLbMgD7VetsNR06O/sQ+8j9TIfnj8dczqk61Z55Rl75vHjJmBNSECsr9py5QqwTpzNwTC6qglwrRFjDFwkRXPlx/PQPWxtXTRU68ZgCtD2niaUNCco+SW5/1APuONbD3uuZypdhcIzHB1ZL1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273660; c=relaxed/simple;
	bh=tkWTQe1ZnBD1cEKU42N3dEUjZh2HVtSnU1yKUW7TBU0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ryltDn07pVP9SetBU0tUDO2iA4QCHbv/u7Ha0JgWYKrpatszgHZ1P0eM+V760g64EX1R1Oda06uK/PyDstKI6XHi6ZwrhPEy5yxBgFg2qpI+LMWzWyzyFB4a/EuqhSNC1ls/CBgLrx1II228GKESvWeCL7UJfBU/iNN3lQ0iYpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=eyvLuPH8; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="eyvLuPH8"
ARC-Seal: i=1; a=rsa-sha256; t=1739273637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n4AtpFWTuDnYniqbGMSC9jo9KzxRm0K6ndSuA0S9VcONiiKYMDdEEfIQfPcRrn0aJIsyJoIFc/ue+QWw3GHkchFXE0WOzWN4ku5m7OHSvgPaB/fXfamXk3TQ9bpVtzgYBDzKDkcEm3aM8XeQagsvhW8rbHTS1G+xgiJxgGLtY5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739273637; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xXvptsss3i2yENVunW5vvg613bivABAEoytKdrykFYg=; 
	b=Fbu6AsV2XPaShu956pTxkIGhP1IuRspFZHyG4vJJ3kzBlehGf6c9ospd/eE27YxOyQBkxzxCIyFuw748wEGyzvzZVmSJ7nsrIM2d0LNiTS2+zGG49mlhkkqvWwAE0cMOrftEf+GoQdwYgIE4KGvnC//JBuDBbyupOCoWG6HAbxc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739273637;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xXvptsss3i2yENVunW5vvg613bivABAEoytKdrykFYg=;
	b=eyvLuPH8j63AAKCXeu6VBKLfooV8cGy6C0FY/GWywixR8ztvbr+XEP8QTSAXdIxD
	OxGlhsgu5Hxa024GR+vb5Xc/6K1WWLbBOc8mZnfzV1rDW0ZnvcT2OR21b+3oQUCmrz1
	sDBHC421zeJnxix527daWErV+uHBbRrzpAK496j4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1739273636340158.76165558496132; Tue, 11 Feb 2025 03:33:56 -0800 (PST)
Date: Tue, 11 Feb 2025 08:33:56 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: "kernelci" <kernelci@lists.linux.dev>,
	"linux-rt-devel" <linux-rt-devel@lists.linux.dev>,
	"stable-rt" <stable-rt@vger.kernel.org>,
	"Daniel Wagner" <wagi@monom.org>
Message-ID: <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
In-Reply-To: <20250211090511.xeFJVnH_@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
Subject: Re: PREEMPT_RT testing on kernelci
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Sebastian,

Thank you for your email. We are happy that KernelCI is helping you with tests.

---- On Tue, 11 Feb 2025 06:05:11 -0300 Sebastian Andrzej Siewior  wrote ---

 > Hi, 
 >  
 > I remember Daniel Wagner has been asking to include PREEMPT_RT within 
 > kernelci. I don't really know what the status here is. Thank you for the 
 > work. 

Current status is that we have them enabled only for the stable-rt branches as
you can see here:

https://dashboard.kernelci.org/tree/b8c892b7816074585ff45397712c6310ba5ae26b?df%7Ctp%7Crt-tests=true&i=20&p=t&ti%7Cc=v6.6.74-rt48&ti%7Cch=b8c892b7816074585ff45397712c6310ba5ae26b&ti%7Cgb=v6.6-rt&ti%7Cgu=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frt%2Flinux-stable-rt.git&ti%7Ct=stable-rt

 >  
 > Since PREEMPT_RT is now available upstream, would it work to compile and 
 > enable some of its tests for the supported architectures on Linus' tree 
 > and maybe the -next tree? I don't think that happens at the moment, I 
 > saw only a few stable-rt trees. 

https://github.com/kernelci/kernelci-pipeline/pull/1010

This will get it enabled for mainline and next. Allow us a few days for processing and
deploying this in production.

Beyond that, we would love any feedback you have to us. A lot of the infra
we have today is new, so there are still rough edges to work on.

Best,

- Gus
