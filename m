Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0447F2DF;
	Wed, 15 Jul 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128511; cv=none; b=BolDEtG7Ko3BGjzRgxdSagfUddF5eCIHxSapCLavGyH9R/cvMJK/04k3sY3q0cQ3qKPHbMG/I5zQaW0eLwWiNQLU4pmLMlVstBCkNyLqBooLXOrS64kZdjgZV+1tyBnuzzPlA5hUbTvxiqPqsC84F0LhwAt5aVUnTlE0fLCvYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128511; c=relaxed/simple;
	bh=NCn8TQCqyVd4yv54z01DHZqucSqAgtl33svtXJ+KwA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XWiiEEejBJoEvBfmTciPhcG0no150cl4PvqZcM+t3iRFwxJOZGfGI43sgOlrxmDPtk0qjXTTluEfrN4f7ptEJzb/1Zbn5xRIEI/o8DbUlrDLfpqjge1aeNzTD/z+eRaZKY6HxnNky3bXsCltsOLXg47otiF4Onfzhu/a/nlSKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gjc53WPT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gjc53WPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A621F000E9;
	Wed, 15 Jul 2026 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128510;
	bh=GY8NWG2scsGPusqeNdKRjOMoK1bBwqxqG0vysp51dk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gjc53WPTrjcSeN37aaULWHeU34oSn5h0pa6RcBThgZ0zKsgG+Iy2lTxyTVHU7fH1j
	 dU09fB1L1SyMYR4+f9kWpM2qbyhnmnL4vz139FcGevoVL0PNLgGe7L1kzzUVp5LzzG
	 a4snumWEEAEnK1OxhLe1V8CGWIF8wIxUkLVtF+mfxTPiDotboIcIyjGgcZD3CSZEnI
	 LFXbbX2OkdY1ot/9ojz2yyCEiabN/GeTVJZDy+y/pGtHsE1NNKF7Z+K+9EIWk19/l6
	 kNzv3SdxNy/aPe2xufYyab17Mq/m83GCM6TEGwGxO6PmpWZxlEdsd7ItPxJbVPzQ93
	 x3NMSfPjfIowg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] Documentation: real-time: Add kernel
 configuration guide
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260715150147.225715-2-darwi@linutronix.de>
References: <20260715150147.225715-1-darwi@linutronix.de>
 <20260715150147.225715-2-darwi@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 15:15:09 +0000
Message-Id: <20260715151510.33A621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Reference to a non-existent Kconfig option 'CONFIG_WQ_SYSFS'.
- [Low] Unused hyperlink target '_development work' is defined but never re=
ferenced.
--

--- Patch [1]: [PATCH v3 1/1] Documentation: real-time: Add kernel configur=
ation guide ---
commit aafa57307e83d54cf2bd4f383aa2ee5d683dab92
Author: Ahmed S. Darwish <darwi@linutronix.de>

Documentation: real-time: Add kernel configuration guide

This commit adds a configuration guide for real-time kernels. It lists
Kconfig options that are recommended to be either enabled or disabled to
help manage worst-case latency.

> diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/=
Documentation/core-api/real-time/kernel-configuration.rst
> new file mode 100644
> index 0000000000000..008d706f36cd2
> --- /dev/null
> +++ b/Documentation/core-api/real-time/kernel-configuration.rst

[ ... ]

> +Alternatively, confine EFI runtime service calls to a housekeeping CPU by
> +restricting the ``efi_runtime`` workqueue CPU affinity.  For example, set
> +that workqueue's affinity to CPU #0 and pin your RT tasks to a different
> +CPU range.  Note that exposing workqueues through sysfs requires having
> +``CONFIG_WQ_SYSFS`` enabled.  See :doc:`/core-api/workqueue`.

[Severity: Low]
Does CONFIG_WQ_SYSFS exist? Searching the Kconfig files doesn't show
this option. Could this be confusing the WQ_SYSFS allocation flag used in
the C code with a kernel configuration option?

[ ... ]

> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. [1] See :doc:`/admin-guide/kernel-parameters`
> +
> +.. _development work: https://lore.kernel.org/r/20260227170103.4042157-1=
-bigeasy@linutronix.de

[Severity: Low]
This isn't a bug, but this hyperlink target is defined here and never
referenced in the rest of the document. Will this cause the link to be
invisible in the generated HTML documentation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715150147.2257=
15-2-darwi@linutronix.de?part=3D1
