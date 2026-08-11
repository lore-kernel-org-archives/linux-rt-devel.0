Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B213FBB46
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466585; cv=none; b=Vhz+he9d736zJFh+YigeBTfkuWTc44a0hStmeaCetJft4AKJOAxyzhYa0dnWuBIhiil2FRImGE2fjcpSsIFpLbzKEIh9OtrpjOEdnN3UfzIi3YqVtuu7yleyja8NEQGICql/DFwmSGk400+mG1kFUiBT9bVQTsK3dJlNF3ewSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466585; c=relaxed/simple;
	bh=2xGxt4rGhm+VrF+UYvUq306h6rjR6rK2bDKKj7S8imU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e0CHTVNeo8GX2GyYLNGJ99Ic5uch+5Hqw2hdD8HuX+So/C0ORhUEPNqr5JWpYGb/8XZsoNc6/E3suYqguiB6Blwm3a3qPHRElBYiQYuJjR+9SZHFNel4ZWaP8ibHZA9Z9DAaIUHfuouLwJFnhlVOu07mT/oXTOjTluF1AsjqrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rIhfQiwK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rIhfQiwK"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E1FD408B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1786466583; bh=2xGxt4rGhm+VrF+UYvUq306h6rjR6rK2bDKKj7S8imU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rIhfQiwK2NiImlZuhQe+1qARcoRQr+6YoKmBsgAEWKzTzAMtzow+cWRDzb5gs4wKB
	 nKx9rJQgkBQyuHkDYBImatkRd2o00C33bFa3FLiCcbnIoP1Ez0xlFTosLo4mHtSsKp
	 UvGI8nwuFgXsKR+5gKuX2Nx2lr42pkjLYWV02a+LCIwN+ZmJcX3vqvQwiv/wNeUHcC
	 HGiGcuuP6LG1TlrAXey0PvGkYfoBhV6J3xh+4Ki2OQYf8VWsjpsyRXM4CoKAZMuHkh
	 CChzNASV2eIzmqRIjU2XxPwRTR2crmXj4Ec0Xbf5BpC4irV7BhFLbif+aY8vB7CQZb
	 Zfe+idLtlvhJQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2E1FD408B2;
	Tue, 11 Aug 2026 16:43:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev, "Rafael J. Wysocki"
 <rafael@kernel.org>, Matthew Wilcox <willy@infradead.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, John Ogness
 <john.ogness@linutronix.de>, Derek Barbosa <debarbos@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] Documentation: real-time: Add kernel
 configuration guide
In-Reply-To: <anQ_nfveudT4ax7v@lx-t490>
References: <20260804141541.747704-1-darwi@linutronix.de>
 <20260804141541.747704-2-darwi@linutronix.de>
 <87pkzwnylm.fsf@trenco.lwn.net> <anQ_nfveudT4ax7v@lx-t490>
Date: Tue, 11 Aug 2026 10:43:02 -0600
Message-ID: <87ik5gliax.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Ahmed S. Darwish" <darwi@linutronix.de> writes:

> On Wed, 05 Aug 2026, Jonathan Corbet wrote:
>>
>> So would you like me to pick this up in the docs tree
>>
>
> Yes, please; through docs.

OK, done.

Thanks,

jon
