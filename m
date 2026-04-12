Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A672618
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Apr 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021126; cv=none; b=JStzMBlAMpq8OXJ12CsN77EzMMxkhv+grfL83UmmHxRVA3mYL/AhVvEww/TVCpxIoNKMbcGYZxEf0MXhHU5knGvc0nITsSAt6RzcND3WDYktYpTc/ySc38KcNarzLAzsCUwZGKeymDNrFNZSTrFfZpPj6LdzioI0fkEd2to82bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021126; c=relaxed/simple;
	bh=Rjy0bYx/aiKu7BrMVP+P24OWfYKEbSst93ot4M9v5u8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UH9IzH0OLSYijnJkyL3CY//WtZZE3l50BZg0WbiDHRI7aESI/0evZDjcS2s7VIpnQlimXE6Z7K2SAnPtlFYD70xIQ3ef9Yk/isIX9hWvg3R0e4ZmPFH2FTQcHFZ2jSYlVhRxBtpHzuAERNtF2PUaFciPuOUcVwgtf0b7NuAoZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FioJIBUW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FioJIBUW"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B8CDA42A44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1776021124; bh=CXG8SaYjHg40te0VXu4OrzULroPQFyJmZbW36fv7HJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FioJIBUWd/94cB9f2fxbp23onHdKhG1SIJ+JVvkm0y+hTbyuupxgSC5PkSEVq+xWq
	 MrpWp+EO2ArUM9t39S/4ZypX654m2GK0V/ReTwkFZtzJcbKwM9phOhja9B137Nio8V
	 jWrZk9aDy1MFcK4NjQDnm+nX0S9MR4QUpKf/pVuMwjnz5qkcBLlxQrpNw2573oQCoP
	 Gvc4st9JkmRpJGcfhhgz1koe/WDePb/Npzt3FrLUkL2W1HHRitAzleB3a/trxngns+
	 nui8BnApnl3/Dv2fynyIX14c7KAGVVHOLASm8EsnvfnGcrvlwZfvIqZ8nHazUBJB4p
	 lZB8LrL3DQ6mw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B8CDA42A44;
	Sun, 12 Apr 2026 19:12:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sukrut Heroorkar <hsukrut3@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Cc: Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: Re: [PATCH] Documentation: core-api: real-time: correct spelling
In-Reply-To: <20260411155120.233357-1-hsukrut3@gmail.com>
References: <20260411155120.233357-1-hsukrut3@gmail.com>
Date: Sun, 12 Apr 2026 13:12:03 -0600
Message-ID: <87jyucyovw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Sukrut Heroorkar <hsukrut3@gmail.com> writes:

> Fix typo "excpetion" with "exception".
>
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
>  Documentation/core-api/real-time/architecture-porting.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/real-time/architecture-porting.rst b/Documentation/core-api/real-time/architecture-porting.rst
> index c90a426d8062..c9a39d708866 100644
> --- a/Documentation/core-api/real-time/architecture-porting.rst
> +++ b/Documentation/core-api/real-time/architecture-porting.rst
> @@ -74,7 +74,7 @@ Exception handlers
>    Enabling interrupts is especially important on PREEMPT_RT, where certain
>    locks, such as spinlock_t, become sleepable. For example, handling an
>    invalid opcode may result in sending a SIGILL signal to the user task. A
> -  debug excpetion will send a SIGTRAP signal.
> +  debug exception will send a SIGTRAP signal.
>    In both cases, if the exception occurred in user space, it is safe to enable

Applied, thanks.

jon
