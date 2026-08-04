Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9642EEA7
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Aug 2026 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836101; cv=none; b=LbXygT0+lG36veBe6DEX/zmnoMq7z/kOm40odrEIGEJniHCEBqZcCiUEnQqn+hoiG4LD3NaVr3Nx4oC+ReDBf7ZIKvDmkOM0xnwxDCAHpl8RGly14+QPQz2eYkaRD2VGSvXmHT4q46agY/+H8EWhwgo2ESvd3TiAfYQHGZED71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836101; c=relaxed/simple;
	bh=hv13t7z2577/jtf5gTd03vLdwH2iFsUJsa+WSPPu3R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMtvSAXGBzZrM9GaIJQlSm6yOmscBv4FQwpzaRs7cwI6p9hexYBY2ApP5xVrLfn5VQYawkPW9r0oZiuTy7wXkWWRK0h5Ql23x/gKsKbqdNiBMTBOEceDQX8ejRjvLaLRI0twsUIMe0PHHUAsEcM/Nev4vI6SeGNJizl91v39YhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHXLkTs9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHXLkTs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785836098; x=1817372098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hv13t7z2577/jtf5gTd03vLdwH2iFsUJsa+WSPPu3R0=;
  b=LHXLkTs9U0cZRaCc0yPIvZzEJji6EOtTZs8nwN2ZpxXAyPUTPleVN9ey
   mHH5Md9AI4PqadW5gLHm6cY4sTbizqTquZbfFQOOK+vbGVnQ86ST+NS4e
   U5sHflIoQ/dOj/gd/Ec8zVkAVPX6Mx4F70Gll1T/wZuNmi5BeubOQmFmc
   165gMLrBY1ivBLcL4VRNKs9V4lSQ+SRC55M92Qoe0yv+ud0Y9LDVXGVzU
   QR1hPIAz1NjxtzBwhDtZOW2vW4yVZaYUEijw9iecGHre6k5nzO9t3IGtk
   z+MHDlhkyX2Eorbfg7AAdhEMuiP34lKUJ+sl9KlURNpXJbLkK1+Tzl4qj
   A==;
X-CSE-ConnectionGUID: jQtSUuZnQtWwypuRTU2xBA==
X-CSE-MsgGUID: 06q4n3WoTQeWFfkUPMxYRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96975328"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="96975328"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:34:50 -0700
X-CSE-ConnectionGUID: UMUvbBujTvGEXSCL5zzi3g==
X-CSE-MsgGUID: kEZ2DI3MRyu5fsGUPQxGkg==
X-ExtLoop1: 1
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:34:47 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: ml-ioh: use raw_spinlock_t for the register lock
Date: Tue,  4 Aug 2026 17:33:53 +0800
Message-ID: <20260804093355.2110800-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLkAjQG7hFsdX+dy8wZUoKKDCaOzMD0EJ0nn3gYmaEOJDw@mail.gmail.com>
References: <20260731032747.2987292-1-junjie.cao@intel.com> <CAD++jLkAjQG7hFsdX+dy8wZUoKKDCaOzMD0EJ0nn3gYmaEOJDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Thanks for the review.

I checked it, and the report is correct. The PM callbacks take
chip[0].spinlock while the save and restore helpers walk all eight
channels, each with its own lock.

I have a follow-up that uses one lock shared by all channels. I'll send
it separately on top of this patch.

Thanks,
Junjie
