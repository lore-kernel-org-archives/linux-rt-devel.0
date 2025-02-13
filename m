Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C020B7E8
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Feb 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435333; cv=none; b=Z/tYigoJlTEHNJSbqmXfRxRVlGJo/I90xAjGoUevUMPv0xj/s1ELLBc/7cWey5NU1CSrkcfohqfROhpfENiJ0JHUd7dcLfB4wELMeMhtjHZj5pbiJbQ68K4q+9AIFKGBZ8yxzIZ/bZuLEpKdCywtEyV6Ztonmwvrj7HQRW8QHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435333; c=relaxed/simple;
	bh=5a+9i+kdbuvQoWf8lI/O2ROSMQpjB4xDJb0ZBkXqvV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCBx4mtEXfjY9qCJqjeoPIr6awKl2UG/gPo29tkmKllIDGCYAO/cSDhKyaWHejjPQ5/FL6SUv0TaS4vUenPuFxhcyqteo0Bah0JE0hFXtvDLx3zodAohoRX66gnGX+3kR0hr27CMrUpzU3NaseXV5f0b312CwGnEcHUCeXs0U3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rAtjEKU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4Ysty13; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rAtjEKU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4Ysty13"
Date: Thu, 13 Feb 2025 09:28:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739435329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5a+9i+kdbuvQoWf8lI/O2ROSMQpjB4xDJb0ZBkXqvV0=;
	b=rAtjEKU/2+r4IMApTP8yy9ahQ2nUQFahk+tyoFbmspvuSI47IKpMgxaLq9knb9XWV6oroR
	3ICYyUB7e7utMBJ37V7gB1cghCgBnFS6y1m+csAIkDSDG/+ziSll+8h9uCHghgSgSkeV0a
	xkjuscOZYEZ0+pKyelG2SmFnQs3fXSZt78Ia/yW05b7Hf+g48n+0DcUbmmOFM47NG6TC+0
	ECXA9nzqr0FCIw2DMc0siE9JA52Ksp5jIG3YGUYwSAQKcfVJjChu7A6M/tWYO93ysuA0k5
	kbF1cvn24ZjxWzLAaEruYaUMxRAQKmShnGx6OLAXuPqws7G9btZcSZ9YHKIl7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739435329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5a+9i+kdbuvQoWf8lI/O2ROSMQpjB4xDJb0ZBkXqvV0=;
	b=J4Ysty13B4n01s0ZzGXlCT7YB19XNc9zxXLxrBpv7y0IN54gnXo5xzzXkoUUfjDFScUTrW
	F6JsEgO2sP2/zqAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250213082847.dLvDaYCn@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
 <20250212165612.ogWjReMW@linutronix.de>
 <9aec9f06-0566-430e-a708-d22bff0bc697@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9aec9f06-0566-430e-a708-d22bff0bc697@roeck-us.net>

On 2025-02-12 10:36:06 [-0800], Guenter Roeck wrote:
> > I may buy you a virtio adapter :)
>=20
> The whole point of my testing is to execute as much code as possible.
> I _do_ test various virtio devices, but to limit testing to virtio
> would defeat the purpose.

I understand.

> > What about this in the meantime:
>=20
> Yes, that passes my tests (with and without rt enabled).
>=20
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thank you. Let me think what I do here=E2=80=A6

> Thanks,
> Guenter

Sebastian
