Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD533BBC0
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436308; cv=none; b=IjsLhzOCYTYJHI9djAfX3Xop0etC8x0empPUdPoihnjYTWuAj684BICLP/LB9xPPVK9h6YLNOxB6jgKvBZkIAaG981kIjzShVrql5dam2oXN2N3OofWeL6qYEVAoaMUjGausQlmd5Oj7i3jLsTO8YeiBamAi2XffdFC1x0FajYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436308; c=relaxed/simple;
	bh=YVu+sGvMlNkS4k9kfkfXYGH/hZcCKd9f1er1letfTog=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=coUgb8QMZHrJSLWcdgze8FEB2189XQ+LMIBL/VVI8Ep6+Gw8oH3UaYBDvg/k1xE1XfhzVty0FFSst+EzHCGmYjYdrWmQLxAsQ0qXw9U96r0mZ4eis+IA67uN1IB1A7q7ocxtshEmhxIqFprUN3Z8fZ/c1KqQVKiSsUz3vgSwtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QShoMJGH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QShoMJGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769436307; x=1800972307;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YVu+sGvMlNkS4k9kfkfXYGH/hZcCKd9f1er1letfTog=;
  b=QShoMJGHIkE/31tJfceTK6Tj0dpixK704Jsk0au5k53J376o5coFidOC
   s6MddH97Ypc+xI0/i3OvEy4RmhuJgz0UfoKWeVEJ2ZHCMU4MCFJtuCHDg
   l+oUR95Z4VnG3cejdByzq6yYjfJ2vbZm36XPqYcyTjb2kubZMfO8MflGH
   MXJsd1Q9FTShfCup/7H0rhgNmc86zzrvPzAQUqMOBLep22x+NniKEkZAS
   4HntdhLNxWCCQku6a7iJCqPfHznDpjJ/3T8t+R2z7iFvxaEXo6kgnYK0C
   cLR3GuCj3wGnBZyqr2KelLKQm3Ir87C8zDVyq2nQcQCkzYkfLoy9z4/nl
   g==;
X-CSE-ConnectionGUID: 8d/Plhi/T2i8A/8PpPiD3w==
X-CSE-MsgGUID: 6/siVmfnQu6RgeeRFxZmFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="58186596"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="58186596"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:05:07 -0800
X-CSE-ConnectionGUID: b2meS9u/QSm0939855I7aA==
X-CSE-MsgGUID: 9su8TMrqTmyB6+Hf2A9nrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="212228975"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.150])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:05:03 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Jan 2026 16:05:00 +0200 (EET)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
    Thomas Gleixner <tglx@kernel.org>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Subject: Re: [PATCH 02/21] platform/x86: int0002: Remove IRQF_ONESHOT from
 request_irq()
In-Reply-To: <20260123114909.BPVv_oBm@linutronix.de>
Message-ID: <b70e4160-62b7-569b-0dd2-fc54d771611a@linux.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de> <20260123113708.416727-3-bigeasy@linutronix.de> <20260123114909.BPVv_oBm@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1593122775-1769436300=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1593122775-1769436300=:1055
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Jan 2026, Sebastian Andrzej Siewior wrote:

> On 2026-01-23 12:36:48 [+0100], To linux-kernel@vger.kernel.org wrote:
> > Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> > the secondary (threaded) handler is done. If only a primary handler is
> > used then the flag makes no sense because the interrupt can not fire
> > (again) while its handler is running.
> > The flag also disallows force-threading of the primary handler and the
> > irq-core will warn about this.
> >=20
> > The flag was added to match the flag on the shared handler which uses a
> > threaded handler and therefore IRQF_ONESHOT. This is no longer needed
> > because devm_request_irq() now passes IRQF_COND_ONESHOT for this case.
> >=20
> > Revert adding IRQF_ONESHOT to irqflags.
>=20
> This one should probably go hand in hand with the previous one. It might
> be easier to route both via tip/irq.

For that,

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1593122775-1769436300=:1055--
