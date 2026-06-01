Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D33360EDE
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Jun 2026 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340799; cv=none; b=JLYpx/7afAeSlBzzZlRLD/xOvx43FJAVOQFdEoFSTTYIkKhAoFJh4jupl35GTgBS57/yMErt81qcAjInaUtuGQJ9qorY8pJNVBop748ZznbObpDJAghxJwvTwN1xTcITYWA6db+dwE4ubnh7vMCzvzX2GwUB1cYVSAte5+tZO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340799; c=relaxed/simple;
	bh=cmISLBoZ7V5IprSnEE+/iaGmBvKLkaLwGK2iu7OH72U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z16jSPRd1QtsZtC8jTCu/lwdPLi8ZF6nAJNsbmrk6kTnUhPcMBWAgZgqEX5wIA3m6chla3ZwpDC7VKYD3UftJYjRvup/T7OrgXVusl80jxTYVhSGbADlRBwfBD5kIJ/UU35aovx0CYIZ+bmnW3n+6VZoUEY6roIRYAwEib97gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RPJMzkoS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RPJMzkoS"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A403440E50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1780340797; bh=jIbui+TOzTTl1Z1CmdVldqCeJocnq3WNhislILHtezM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RPJMzkoSfziGCB1WIN3zgAkxObRcYUa0+gT52YtzPiay5NrCIljsqdfDgFW8cRbF9
	 ckArS/kHfbwlrpAwEvsy91rAEmxsqXhQRxk84b9ewHgpfb2Nu0dayjJyO/jz2uxI+0
	 ZDkN7z110xowdsJXEp3mm7dEp708txLEUsUaMhdbsN2m9KD7rkh8ldstUX8184DY2h
	 HrNFjhqjfEeA+sK5fOBzwtGmXNdqAhsISBxxwsOSZ2UFip9vuns3GOdsM/Fts0EXC/
	 lrYRFI8bTzzOQw+8r7CJVFSDxv8CqHkLJOz67I8rA+tSp0VJhk+5jQYPpC7rarvA5f
	 gDH03uiihpgtQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A403440E50;
	Mon,  1 Jun 2026 19:06:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Costa Shulyupin <costa.shul@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-rt-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v1] docs: real-time: Fix duplicated sched(7) text
In-Reply-To: <20260531141823.4118954-1-costa.shul@redhat.com>
References: <20260531141823.4118954-1-costa.shul@redhat.com>
Date: Mon, 01 Jun 2026 13:06:36 -0600
Message-ID: <87ldcy84hv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Costa Shulyupin <costa.shul@redhat.com> writes:

> The man page reference appeared twice - once as plain text and
> once as a hyperlink. Remove the plain text duplicate.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/core-api/real-time/theory.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/real-time/theory.rst b/Documentation/core-api/real-time/theory.rst
> index 43d0120737f8..92de5654163d 100644
> --- a/Documentation/core-api/real-time/theory.rst
> +++ b/Documentation/core-api/real-time/theory.rst
> @@ -25,7 +25,7 @@ Scheduling
>  ==========
>  
>  The core principles of Linux scheduling and the associated user-space API are
> -documented in the man page sched(7)
> +documented in the man page
>  `sched(7) <https://man7.org/linux/man-pages/man7/sched.7.html>`_.

Applied, thanks.

jon
