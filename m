Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117D377ED9
	for <linux-rt-devel@lists.linux.dev>; Fri, 12 Jun 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292616; cv=none; b=Yi0XdStkBW5oQ7uXVfNPywNuAXRSTckl+6OMOIDExFFUrRITN7ShCoIUyvECS+kQAojFqHUpLSxl4Cs9tZgBAt7QP63IPhnUqZ5V2mqYF6qHCxKU+HF2jok7Gmf8ho+vHO218ToB6mwnQwmauhxlEF2E75o3Utm5MSYzUlUugGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292616; c=relaxed/simple;
	bh=0SDtyoVSJyItDBbD4B5Mp2m2e2H6XhoWcDWodq9BhA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rj4avbF0LXahwIHbEMIKGHvgy8Z7hGADYbzUrmhMbkOM1+fmTlhWRwc0sgVynJjT6qH7dRs0KKxPqP7x7ueFZrcNN0cyzjWhQOvkiRnKbjLw4do5XYS/zbUl8Bh9UkDkhcosZUkQqVHPXlwzI+PbmKQa4FEU1uo1ewyjWq6OIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ayGp/6G7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ayGp/6G7"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C93B940430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1781292614; bh=U8v5VnyHUfQsush5/KvVWjDOODuQ0xY3gHngR/hSAvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ayGp/6G77F6ugff3ebd16kwMpGKHyTOE/egwpj7LWnEQ/KXgFTNamzospR/d1yVlb
	 v2XrlXMkiA07JJuKB9OhHLbMlL4SXB3MHkMuDyIQkz650o5LAhyXRUp1hj4dOpsWm3
	 76cN1YogUmfsY583tmihxDf56KBQroNQ6vzy4lTSws22xXEPooVXN6J4sw1WuQsp2b
	 1iad0rljqW+LRKLWQYkXl9ub6OFrvpE/vVFdmD3e68HTb5VUb4X559FQBOk0+vSsom
	 v7Z0C1AIPeP/Q3idrTCDk4eHrUPdMjqLmZ5YXm+/zX7hHcoNr8UPSf1YdlgFDZOr9T
	 FFknQpVrTU6wQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C93B940430;
	Fri, 12 Jun 2026 19:30:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebner@mailbox.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Cc: Manuel Ebner <manuelebner@mailbox.org>
Subject: Re: [PATCH] Documentation: index.rst: add entry of other sub-directory
In-Reply-To: <20260603080430.344391-2-manuelebner@mailbox.org>
References: <20260603080430.344391-2-manuelebner@mailbox.org>
Date: Fri, 12 Jun 2026 13:30:13 -0600
Message-ID: <87pl1v5zga.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Ebner <manuelebner@mailbox.org> writes:

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

This file already appears in the toctree in
Documentation/scheduler/index.rst; adding it elsewhere can create build
problems.  If you really want a link here, the way to do it is to add a
cross reference instead.

jon
