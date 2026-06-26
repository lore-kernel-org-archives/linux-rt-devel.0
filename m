Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05289346E55;
	Fri, 26 Jun 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506678; cv=none; b=NZLU/Kie/SdUV9lwT4wsXN22AsYnefZe1K4M7EGWn/Kza3CxN3qH4qr/W3A3pZzfi8Zc+Tmy38b0k/iwHWJ7Zm4kRGNt4y2PTkod3x/oq5DRm7FKkT+6RVGm1oUyZ70rAFDegLolt/2dOE6vyNjRsxwGwzqVPAwpn05ajL985EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506678; c=relaxed/simple;
	bh=r/XLptgxn4Opbo0VrcYAz8hsJCJ7hqGjfEqI26g3JLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQfDVLTUB1LU0EePJ7xdJX058hAuZd7o6XbX475TVs3G7RVh1j720rd+rN0cDgMVUevNlY7IPTJFvxpWP0gLANjW4NIzI0Ki0QDm232HohP9BAoJX23+NfOldmgoMwT7UtcxNjzCHQey5AnaUCISJOMknSt1fW0s6JhTpgNI70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPPTXCiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPPTXCiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999F71F000E9;
	Fri, 26 Jun 2026 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782506676;
	bh=KKDpAYSwCxTkkEV2iput+GAGuaTs3Cf4nSmImXaZJcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KPPTXCiNb8D7IAXv83KLmtrbAKbHpCdjaN3PnanTIGcpte2CIHtW6YpncSKPlxC37
	 lpmsYeyKt1m4TiSq7gmHV8wNDElq2uyPJ/OPVfBEbg5QidtqShlkxX9uHWruFMk2ui
	 kI05SgNGZ9xOLQTXbz92dcKsA5Rq/S5MLoqnJ1bJVXQgPwQ1Mmcxuf/qqMB3l4tI+e
	 xvoMSrmr5Bs7F+eCpySs9q3fwQ3Nbt53SZ/ryzXpWE5mnEniegxB+Xn1FOWYVT+fxL
	 8ofU/bBadtf8ROI6aTsROsCCZPIm0FEfhU16yNpxJW+w5BE2OtW7Xx28f30JpktI+H
	 K1ejmJdzXe0qQ==
Date: Fri, 26 Jun 2026 13:44:35 -0700
From: Drew Fustini <fustini@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Message-ID: <aj7ks1ijsRTBWyHZ@thelio>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
 <20260624-dfustini-atl-sc-cbqri-dt-v2-5-2f8049fd902b@kernel.org>
 <20260625015355.B997D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625015355.B997D1F000E9@smtp.kernel.org>

On Thu, Jun 25, 2026 at 01:53:55AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Traversing the global `cbqri_controllers` list without holding `cbqri_controllers_lock` during CPU hotplug risks list corruption.
> --
> 
> commit e1c49060a1fc98c61e36689ccda2041d360bb762
> Author: Drew Fustini <fustini@kernel.org>
> 
> riscv_cbqri: resctrl: Add cache allocation via capacity block mask
> 
> This commit wires up the CBQRI capacity controllers into resctrl as
> RDT_RESOURCE_L2 and RDT_RESOURCE_L3 schemata. It treats mismatched
> capabilities at the same cache level as a fatal error and lazily creates
> domains in the cpuhp online callback.
> 
> > diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
> > new file mode 100644
> > index 0000000000000..2f31baff032b6
> > --- /dev/null
> > +++ b/drivers/resctrl/cbqri_resctrl.c
> [ ... ]
> > +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> > +{
> > +	struct cbqri_controller *ctrl;
> > +	int err = 0;
> > +
> > +	lockdep_assert_held(&cbqri_domain_list_lock);
> > +
> > +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> 
> [Severity: High]
> Is it safe to iterate the global cbqri_controllers list without holding
> cbqri_controllers_lock?
> 
> If a capacity controller is dynamically added at runtime (e.g., via a device
> tree overlay instantiating the platform device), its probe function can acquire
> cbqri_controllers_lock and mutate the cbqri_controllers list.
> 
> Concurrently, if a CPU is hotplugged, the cpuhp online callback calls
> cbqri_resctrl_online_cpu() which invokes this function. Traversing the list
> here while holding only cbqri_domain_list_lock could lead to list corruption,
> resulting in an infinite loop or NULL pointer dereference.

I will update cbqri_attach_cpu_to_all_ctrls() to take the
cbqri_controllers_lock before iterating through the cbqri_controllers
list.

Drew
