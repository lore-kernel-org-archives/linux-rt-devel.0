Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54033CDBD3
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Aug 2026 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958936; cv=none; b=tz65fxOrpp0e38tbEok1AYhUcQKP8RLyUQVV1RChX1yhsLBdysjQ2iEr0BLsA15+xP9N9op+7MI+8fAzmqed2X6Cp5bwmyjjJCOEQBsI+WJZ/XP1+a9V/b6QPm4al3eXNbZGBjjvzoJZTod5oth+KOmQpxeU2uhOBSfb49KPQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958936; c=relaxed/simple;
	bh=Hyt9MIGvB9H7N7k/oqs/m0y+efiS+YLZhc6gtirJ6F4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pQmOtg0ZCF8rlfF9VAfEJVmGOOZyY+GDzqaWJrpgN/P5qvLccZojyAATxEdKdHbxN9NxILiQdVjcGAoMo/STvP8UtPtJO5o4fzs0ecSUWCxJZtGeyjR8N6qJns3R+3I1g6PERupzNEn0Ir4lUe11bmVlOO3koJPkOMDFDui7WjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=aVk0iC1Z; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aVk0iC1Z"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 07AA3408B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1785958934; bh=ACMwJksDl0CPlrXPVHPgA2VRtrsVjHiM9fJnUrGr6ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aVk0iC1ZfkKr2sZXN2btfmfvktwiPaO8NGqSj8vSYsDSJEQkbc6idqY1umUk+Oe8f
	 uLPDGlxil5ctPfwbELnkah6h/m4RjfS0eN1/3/JnlfQ0jfwoorRjH2gIsnD1ZzbROw
	 ZgOYRbrfM5WOb5pzwpMm1PJGhih5HMkmgWUdFCaFTL7J/Ll5/GLRrg8O1HFC9nH/b6
	 tLktvi8+X4W5HdmYSRgEwueLD6LqulRGU85pJ+GmehaerMUY6yQRtnn8VWjXTM9nnu
	 8Zg1yfUPvvOsjTe4+BBMtiZwBqKG+mrCqLDqucgaWJSsTgPR1jJ+e/lHESrzUs9yvy
	 62WE46qW8QxQQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 07AA3408B2;
	Wed,  5 Aug 2026 19:42:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Ahmed S. Darwish" <darwi@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Derek Barbosa
 <debarbos@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [PATCH v6 1/1] Documentation: real-time: Add kernel
 configuration guide
In-Reply-To: <20260804141541.747704-2-darwi@linutronix.de>
References: <20260804141541.747704-1-darwi@linutronix.de>
 <20260804141541.747704-2-darwi@linutronix.de>
Date: Wed, 05 Aug 2026 13:42:13 -0600
Message-ID: <87pkzwnylm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Ahmed S. Darwish" <darwi@linutronix.de> writes:

> Add a configuration guide for real-time kernels.
>
> List all Kconfig options that are recommended to be either enabled or
> disabled.  Explicitly add a table of contents at the top of the document,
> so that all the options can be seen in a glance.
>
> Whenever appropriate, link to other kernel guides; e.g. cpuidle, cpufreq,
> power management, workqueues, and no_hz.
>
> Add a summary at the end of the document warning users that there is no
> "one size fits all solution" for configuring a real-time system.
>
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  Documentation/core-api/real-time/index.rst    |   1 +
>  .../real-time/kernel-configuration.rst        | 307 ++++++++++++++++++
>  2 files changed, 308 insertions(+)
>  create mode 100644 Documentation/core-api/real-time/kernel-configuration.rst

So would you like me to pick this up in the docs tree, or did you have
another path in mind?

Thanks,

jon
