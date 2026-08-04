Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36567466B6E;
	Tue,  4 Aug 2026 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851023; cv=none; b=oKanPbWVg1fat7Ra2bGxocXFgCOTUfDWoWKmrnGTvuPSA34eXOH1TNZ2LZVAnquyr0SWzizEgLk5YVXnBuGB+oL4KLCn3yrYBffPuP3zceK5pjD27JE4tp3d+UTImkTDh6ULaPOb1/oimXIHSDmrh1AH4TUnP1RC9hmKB/TBe/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851023; c=relaxed/simple;
	bh=oCQZznd307UcD+/9ilarCE9ERlJCtDXQugSrgfBjIss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VY61l6iV0o5IHNhUPghtNGS9ZyisprZQwhKX9fU43lSXKcM/IiZDbfKSZe3TIAGlZ6gB6b3fC3ZIDxYkOxOMsyz239/bq944cWgOOOcABUytR8mEwBugvZ7IqalmciUatDUURyjBXbvEK1+rwynrgCStGEC4voHJaV/o2EGIQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRIOp/Eb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRIOp/Eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A261F00A3D;
	Tue,  4 Aug 2026 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785851022;
	bh=mVheSO2W3nUWPHyxdzmxXl+gOi/Dc9oxOmuAIFjkstc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRIOp/Ebh4RaLxUPjTZElnGzrx3w/v3EcXYlq++WzmIjPsECZngNuJwQyjNslZroG
	 BBD1zrZYaDsB6dtxbS4nzRGYJampmGFIJ6oyN8g2pgqTSyz0XYZ88B66nI0WmhNU/o
	 usP1Id998AMts1Pj4tPDr8cbKns3yax94nezOnDf94fi1qMbufhbNDUcTGohf1/XD4
	 IAmRWeL6zpFEqL7AulprIjsupTBytdvUyKYna+dv5iysawDyYipDifPLMKRJdTYc/7
	 3aUI0IUmqUurNOGc8Wjqy20k+fyB6f6/Rrbj81LEj40Kb5bS9VPGXyNG8R59kktyI7
	 hXKteJHGkdjYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/1] Documentation: real-time: Add kernel
 configuration guide
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260804133746.744212-2-darwi@linutronix.de>
References: <20260804133746.744212-1-darwi@linutronix.de>
 <20260804133746.744212-2-darwi@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 13:43:41 +0000
Message-Id: <20260804134341.B8A261F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typographical errors in the documentation text and the commit messa=
ge.
--

--- Patch [1]: [PATCH v5 1/1] Documentation: real-time: Add kernel configur=
ation guide ---
commit fc9a84c888f9e6c7081f477ffb83f1ff5bc1b0aa
Author: Ahmed S. Darwish <darwi@linutronix.de>

Documentation: real-time: Add kernel configuration guide
   =20
This commit adds a new kernel configuration guide for real-time systems,
detailing recommended Kconfig options. It lists options for CPU governors,
cpuidle, graphics, EFI, NO_HZ, and debugging features, explaining the
latency impacts for each.

> Add a summary at the end of the document warning users that there is a no
> "one size fits all solution" for configuring a real-time system.

[Severity: Low]
This isn't a bug, but there is a typo in the commit message: "a no"
should probably just be "no".

> diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/=
Documentation/core-api/real-time/kernel-configuration.rst
> new file mode 100644
> index 0000000000000..72f7e8453bcc5
> --- /dev/null
> +++ b/Documentation/core-api/real-time/kernel-configuration.rst
> @@ -0,0 +1,307 @@

[ ... ]

> +Non-performance CPU frequency governors
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +:Expectation: disabled
> +:Severity: *medium*
> +
> +To ensure reproducible system latency measurements, disable the
> +non-``PERFORMANCE`` CPU frequency governors whenever possible.  This avo=
ids
> +the risk of unknown userspace tasks implicitly or explicitly setting a
> +different CPU frequency governor, and and thereby changing latency behav=
ior
> +while the system is running.

[Severity: Low]
This isn't a bug, but there is a duplicated "and" in the sentence above.

[ ... ]

> +``CONFIG_TRACING`` (and tracing options)
> +----------------------------------------
> +
> +:Expectation: enabled
> +:Severity: *info*
> +
> +Shipping kernels with tracing support enabled (but not actively running)=
 is
> +highly recommended.  This will allow the users to extract more informati=
on if
> +latency problems arise.  Nonetheless, some tracers do incur latency over=
head
> +by just being enable.

[Severity: Low]
This isn't a bug, but "enable" here should probably be "enabled".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133746.7442=
12-2-darwi@linutronix.de?part=3D1
