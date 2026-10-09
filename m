Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3A41169F
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Oct 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535392; cv=pass; b=Uzz279l8a9j5Xqhx3Je5MQO0I/cBZ+BhtoZzqFANmOpiA5J4ap1VOyUJsh5RonYRPZYC+z3/Fm0oisOzz68myaOJ/Ojgy62uAFPBi40Ue7+Wf3D1+raDNBWMl46go5Jp4d6bBMz72NO/Kcji8Uj4t3tBYkcumg+N/f0Qemo4wOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535392; c=relaxed/simple;
	bh=qAkai9AbESmrM4xIkF06nrF8EZpWdyV4GK1L9zcF+P0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b7WMTHMQYAt7GrSmfEsRsss5bx8M10WdFwLH7XHvzRP33lEw/ds0M58fGuDUa+A77EkAoZS5y1vMQ9gb591vObBHCzD7/1NImxLUMOpRJ3yqAXZWevnPrf9oYxrM7E6GIq73pZo7xTAb6ciJ6ZPap71QqAQ1QUCGKQo5uJtAfkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZCb+n8l; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZCb+n8l"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-49e08af5fd4so2762511fac.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Oct 2026 01:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791535387; cv=none;
        d=google.com; s=arc-20260327;
        b=cQlzxYW/xKfUjMDQR3kOYoWyFi6sU5annETXFmayI+AVYCrQ/muWNbxTQQpoEVoXlw
         Mho+uPPKXKDwcTMHO80E3I8ImPu7Dh1rxSb+umBWO87lO6YYwq/0gEMgYPXBmK3lTnrR
         1IvvEndVsj3iXkOF6fwBf4+X8lkHbjzyq/OMEMpT3nQSWS+Ish9SXNQgamTdrhrXHroj
         zGpYRDwUOimbZbQOKBBkn/T5G6/3d93s0ClDu9Lff0jn9IdOj5g5pNUDRZfYFZ0h7w4I
         VGsGqpcVlM1wOm5PT7pblhtWnzgjuQFWZK2KbpwY5t0OVfwMcFyAWwbTu/dhjy1e3hEz
         gHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=qAkai9AbESmrM4xIkF06nrF8EZpWdyV4GK1L9zcF+P0=;
        fh=2JJ9UgsMgg3ewj7bP9Wf/OPEhd8DyCiFrR+KqcGxZmQ=;
        b=Q09h4x6hBe76aezGTDOONrLHKYutnojdJkuqvu7is8nMVMrn8neClp6xA5W+DE7+o5
         v77jl4MiuXXFtXuZpUEg84RNJl1oNLd9seRxD9TBRxlBfj3p1rOaWZaX+diq8TosWCPV
         owxxhXP+yplAbG5x8NTC11NbhWKz3C8+vTHwDcQ4/OP8NEg66XvrHBtEf8ny/hRr7NCQ
         KJSMDeCnFRlQ0WI7VUkEYqQx5eIFSNOJdeYGRs+zk79iXK/uDGFyStY1B96xIYo5ZqB6
         K18Z7/dQ4hui6FBoXZbmWiscTa9/rRq6C9GwxTU3nMzh8CeDHZwfoluwSNa6PzMe4gnA
         LqjA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791535387; x=1792140187; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAkai9AbESmrM4xIkF06nrF8EZpWdyV4GK1L9zcF+P0=;
        b=TZCb+n8l/v8OXr07mx5xBHJT2fR6rUFxUpE3eJti1xB1z3RB73EL+P2fZ3PFod7HEo
         GKRkb3v0Zii3RUl1i42ZmxwjG87VC7TsxJ1Sqwu3Z3XM47INbknMeXHmBqBlLy1oA381
         mNpOyKwLAc8OMvIvoAPnWQzt/a7cJJUng3vOx6B5zYLe/WQ0ZEG0LJP73oqkP+XiB/G/
         nzJItFTfHdGX8EoDSRVJN2TB4yAQO2UVo504SXTFp0V9UtLFycG6gYwqQxJKXUN2llsF
         lAEen5Mu58HODpv+exeopuU7s+ecqOQkLyILSiyfiR9kqOTVmyeiM/D21pp0Qp0Jd/4W
         WHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791535387; x=1792140187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qAkai9AbESmrM4xIkF06nrF8EZpWdyV4GK1L9zcF+P0=;
        b=Rf8oP3Ts6dhEEr8XIlP+TLIklWTcgwc3Pu1pxUnDGD1rmmqrXMxnFM7LU+cpDn55gf
         L3Kr9Ex6KRyJm7teZtx8UFlAJI0vXeHy20/ua0JSpg4qfwtItl0M8o/S6iQVkH70d/YL
         0xM/u05iIwu0JBnGna5zPuvb0GBCUW72Q8w8FL671asrWYxt1oBY5kW1Zo8SF1DvqNNz
         nuGeprv6EJiOJm7uLQWtIQKC6s99ZI/3NITxa5HXjAoDTeJVEu+MRpvUOu2HdHjw3pIU
         agSh6fObi+vfPNNjMQA5YUlM36abX7kJ0sRd2S2J9YZiuOo6613JUILFPtY1LoqhQd7j
         D89w==
X-Forwarded-Encrypted: i=1; AKwUvBxW59YqOBOhCcnYG2yOlwN/AVnM2/WNj+OKTqSOBSBA/CXvFox4YfdkAGwv3mQCzitiXvuiP2R1p+WwtRV3jQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJRs4shwxSggLLsd+byZF8nMsl6uXeJefmrIaf5nEye5TGuQHB3
	5Hi4basf0d6YHA+JkSk7xUqhFmEIfXXb2Fw71I+g09YqvWNEJ51SINOu9jA3hTQjL7rej0VmSFv
	0UyxvHAi+LpwIfrN3iSduwwSydPdvm14=
X-Gm-Gg: AYBFou1tjYK/XhXeHtH/9m4yEgtRTGOYsja7jH74Y3vX5enwJZjJiqF7EswE+ASuiQG
	jfLzWN99zjn1IGpJuW/kc5yLvT6xwIR/c9W3fkhHaYYnqcaK7g4RmJW09kiO+pE6WQ+p+6HtfeD
	gJSbq5bn19KBdW3rKjJijknYtO9GaxFKk68mXDjyCmRvPBgDfRGwMgYbdAtZN2BZ0nKqSkmvHRY
	cIGiY2oyiqIAZBbwqI/IwxwDOF9XNKkkusNKcm9Z4jQYoAmHKtlHtXovtqzZYuQJ/ptSRVVgAyD
	lkT3J1FF0e+P13CCo7PL6eL+sfYys0oprcmoegXU0vHh9MMcHCr4jis/xTBNcfQB+9c=
X-Received: by 2002:a05:6871:580a:b0:499:f1a8:3ab9 with SMTP id
 586e51a60fabf-4a2a8ac1d29mr913849fac.48.1791535387330; Fri, 09 Oct 2026
 01:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: MaeeFilho FL <joaoanandalima@gmail.com>
Date: Fri, 9 Oct 2026 05:43:03 -0300
X-Gm-Features: AclHuK8D7bC1DTyUeb58TSqJecI2U3HsXQZM7EwBwNebsAbq75ZmHussbpT2z-M
Message-ID: <CAFA5sMc+CSN1J=r+fXkD_0=wacVVFwk6xkgv-rMRFoyYv+xWkg@mail.gmail.com>
Subject: Re: [PATCH v5] efivarfs: add nostatfs mount option to skip QueryVariableInfo()
To: Prashant Singh <singhpra@juniper.net>, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
	Steve McIntyre <93sam@debian.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prashant, Ard, Sebastian,

Thanks for addressing the feedback in v5. The cleanup of the commit log
and the implementation of the single data_race() wrapper for lockless
reconfigure path looks clean, robust, and production-ready.

This addresses the concurrency behavior gracefully without injecting
dead memory barriers, preserving deterministic boundaries for real-time
environments.

Reviewed-by: Jo=C3=A3o Guilherme da Silva Freitas Lima <joaoanandalima@gmai=
l.com>
