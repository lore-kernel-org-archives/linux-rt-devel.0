Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050922;
	b=sls7ysRJBUjsHT3FFBhBCZcgU9iR5nPAeiNzHCUPHYXlz1JHUFNoTnG/8BXbwOmMR3wy
	 vwrJrXnXXAqSvc/JZAi8PvuaSTOvL2CXHI6KCx1tOBbkvKHcMTfd/KrX4goXvrnntMuAj
	 vvJHK1PoXVJn4cEB8/etmudc2UVmz+FXMtZlULSco6yY7lDOx41wLOvQKrw8WHwMky09G
	 lH8cKaUPzDauWhNsi9bssmSbJcGiZqscnuPX7DiugJ8SBDSjb9pddRvyZAx7V7HlDgv88
	 sCIkRcH5R+xcXGmJXfo0tfu2r9LSgPgNjQ6gGE/glKHcE/Ih2NPH3Z9O7MqWJLU7f2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050922;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ObCbR1AzGYFOPNLyxxidJk4kpAZUkV+QU+iG9r11cOI=;
	b=e4yM+NHb2okq4JqM8/ukSObSnvsAtu/vzeRT+FLmScjcXSMb8wPGIj0AIQN49ucahv83
	 fpGRnMMvKqhkEBhDvFl97FJEU+zx1a7ALWWjvT4j/zXCrzI4p3LlVlqp8NdV1G9Ftjcgt
	 KH10HqfBEPs19ree2YE/gEc8et6aQANMFJfG+QMIU1mzfkWiAMw/B3zaTeCthlU/LJnn0
	 tjsVDnArbi+04oj8OMpnkDZtJeShHxI9M+PNP8/3V00awDT0tZ3fbjWAJtm+o5aMXDuuk
	 vlVbF3+fzUyp+gAdEAq0JUuNB7e1OgczNgMe1AAmLzyKsDmqcQUVCCRHGFs+aoC3c8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QZ7FJ/3K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3A606A31C;
	Thu, 19 Nov 2026 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ7FJ/3K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30F21F000C4;
	Thu, 19 Nov 2026 01:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795050922;
	bh=ObCbR1AzGYFOPNLyxxidJk4kpAZUkV+QU+iG9r11cOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QZ7FJ/3KXkyIl0q+b20OaJsAfd/Ox5InLp4vEhWY4SvzNIU8OPKZfmLgJqfxO9jWl
	 3/1jfwMLBYSUqyFqEDwsHTtSgWLl6iKMLWXwumlreIyLs9jUgHnqAX9ZDIhiy81nY3
	 SMtZ9RwUqv1HTNZNwHYR/cCX9lNqpJNSk2oKjPnHqI7rMxk9BLAgdofCTUTJv0r6yX
	 y55saOJrgSPcqd8vvBLCgw4Z+SStSiax6imYdzOuz9KXVAbOTWu1z4sZ/0xea8hGXx
	 kLG/gz16Okn2Jx9AAkY8V2sDctg5cPDsbS9fGKrccIdIUfRNVfGbOr3jmG0t3w9UTE
	 qEaX5EisjMT9g==
Date: Wed, 18 Nov 2026 17:15:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, rostedt@goodmis.org
Subject: Re: [PATCH v4] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Message-ID: <20261118171521.18beb1e9@kernel.org>
In-Reply-To: <179430137148.488859.15630804371226096686@kernel.org>
References: <179241614797.5916.13928836073297916808@whr>
	<CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
	<20261109180748.33682-1-haoranwangsec@gmail.com>
	<20261109200332.52e2fc0e@pumpkin>
	<20261110165742.1204-1-haoranwangsec@gmail.com>
	<179430137148.488859.15630804371226096686@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 09:02:51 +0000 netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

If / when you post v5 please answer these questions in the commit msg.

Please *do not* submit v5 in the same thread/in-reply to previous
posting, start a new thread.
