Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2673AD52A
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482026; cv=none; b=gKx33oZ+A+ivHA1Hgi+iZYaqpyYayDopV/I3JILmOSY0qIFXfMN8Jv2E0zUwysrgu/2Ju+GlywZzG4GptB7UuVp2Ot4sMHYD066HJqkVjx5OOlaRz1tFTpKs2YOwRle0TCgnzqGfIXkp5nLV1WoW0uDDfh/1ayEpT9vAOfkLAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482026; c=relaxed/simple;
	bh=QeViSA+jcgclwNWpv/VaM6OLK1ZiV3N7rKhMuiNuFt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e59nJykC7goKcgI+Xb+D33Gik33H7T/U1QcfvTffI/bJNP9hVW/9jPxuEt72iTOLuFC+iFagumx/+nsN88dJ4R+chNVqUQ9tKbVpgW8HDbuGL2z7gi/qXG8vHeTuhrF7h51Kr1GT8PQf4JtSKhrIx5BN7eRdMcfDX8CQp8AiwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Kpwc9lx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ht05hPE/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Kpwc9lx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ht05hPE/"
Date: Wed, 3 Jun 2026 12:20:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780482022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SERTPvwwtElEqMvhTi6cpxoekSnm9GBaMtAJHQpKnow=;
	b=2Kpwc9lxOjPFGH0MVEls5p0wzDVUzXhD5ZcH5BOmudg5ZzmJBenO83CaApa31GeCXiuE1V
	cHbE2Sd3iNMMo5PsL0ahDBa09bn7ZzBQbVjqisGWn7ZxZvdI5izt1A+HF1XWbbSyZfbplg
	M12ao6FLSaFSGjjAzUw4dsJFnND7bFdz1XPz+0AkG+rycluMbxXAGsXXOUJpztpCGohSuj
	3S2voHD7H3JvAdZZjXvgeKcRDR5ib5RibDo5t/SIGTjECq9SMN1i5fN1khTNZdNBsTtx1t
	+xobRKYnKE4duxX6FOq1JWH4bNa1o/bFElk6WWH3bQ4suyhGbxgXIFcMA9tUJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780482022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SERTPvwwtElEqMvhTi6cpxoekSnm9GBaMtAJHQpKnow=;
	b=ht05hPE/eLJZJMR7EITeDFCRFZOTxk6zkrUS2AlOd7nYShwO7J6M6pDSfVIuDvO6bsEWvw
	+V6B/CHjjXmIxZDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: index.rst: add entry of other
 sub-directory
Message-ID: <20260603102020.ZsS16TaP@linutronix.de>
References: <20260603080430.344391-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603080430.344391-2-manuelebner@mailbox.org>

On 2026-06-03 10:04:31 [+0200], Manuel Ebner wrote:
> add reference to scheduler/sched-rt-group.rst
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> ---
>  Documentation/core-api/real-time/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/core-api/real-time/index.rst b/Documentation/core-api/real-time/index.rst
> index f08d2395a22c..661b419e7f8f 100644
> --- a/Documentation/core-api/real-time/index.rst
> +++ b/Documentation/core-api/real-time/index.rst
> @@ -15,3 +15,4 @@ the required changes compared to a non-PREEMPT_RT configuration.
>     differences
>     hardware
>     architecture-porting
> +   Real-Time group scheduling <../../scheduler/sched-rt-group>

Have you been using this and are referencing this because it is useful
or did you just happen to find it?
People have been complaining about this and I *think* it fails to work
in multi-CPU scenarios (it might work if the task is restricted to
single CPU usage). Not entirely certain. But complains, that I am
certain of.
There is replacement underway to utilize SCHED_DL for this as in
"Hierarchical Constant Bandwidth Server (HCBS)"
	https://lore.kernel.org/all/20260430213835.62217-1-yurand2000@gmail.com/

Sebastian
