Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E436998A;
	Thu, 25 Jun 2026 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352437; cv=none; b=nmp09itxURd2ExyH/SaPDY+6n1tOR4A5XmQW+S2sBK6NIFppwagmDBanYUwnnLvwZ61pTHHEJOoYC00Y4bjOY7TsQ3lBGul/mRVd77FprUJcY/oKuMEgLLi3Knk4Tamu0Y+rVVfA3AOd/BBXzuqaXEzVGgfzSyLK00KHbkNJEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352437; c=relaxed/simple;
	bh=iW49KvkrJEpTypYzsnxmSy7BSUxoq4Wxl657kUEBR1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fwUpY69VKVLTcfwcXL+PedQFnCSc3lvctnyYrnsoCiEZ9VVXjYC0DgMzyWztMY2qI5+PS3J3T4iV+iUyenWjk5tL13V4y0eIdpTR8cVtS6bTL//K3eFMoW277YQVG6C1rC2ZIDp6XjcTU6EsjLChpg8ECy16P+0rjPG1YbS8X+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfDKwkPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfDKwkPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B997D1F000E9;
	Thu, 25 Jun 2026 01:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352436;
	bh=/3P5d32Lr+gTYXUglGofoNFTZjfQvMLNhTPBkSMlMOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfDKwkPNMBjTzqZW1CKbcs9fmj6ZWiJoMtX7FHwohDrMkCBRS9kFb6tlDQq4moS22
	 M3+wxWDU6/8Qg5STfm66G16tCe3aUI2oLCo01ao84fcR5BiTJTZOrNNPZ2Mg93AbC7
	 kFKvXqJjxJAkMEMv8hOqTfN8wMKuGjgN/UNxD9bSV0ek5E1Be2tDTpS3aZj5u7P3i6
	 oSXFDQEo+TTngLJ3lVcMt+rIBcjZqk3g1SsQcWS5WDyoIKSbLwlhhxBUN/DbVb+6Eh
	 JDzXznkdssm9LYGCXV20p+ivQZ6MBHbDE8n8vf1YyZfR0Nkt12U9aP0Rgne2FZKeXU
	 SEClvwSJX/ZMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260624-dfustini-atl-sc-cbqri-dt-v2-5-2f8049fd902b@kernel.org>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
 <20260624-dfustini-atl-sc-cbqri-dt-v2-5-2f8049fd902b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 01:53:55 +0000
Message-Id: <20260625015355.B997D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Traversing the global `cbqri_controllers` list without holding `cb=
qri_controllers_lock` during CPU hotplug risks list corruption.
--

commit e1c49060a1fc98c61e36689ccda2041d360bb762
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: resctrl: Add cache allocation via capacity block mask

This commit wires up the CBQRI capacity controllers into resctrl as
RDT_RESOURCE_L2 and RDT_RESOURCE_L3 schemata. It treats mismatched
capabilities at the same cache level as a fatal error and lazily creates
domains in the cpuhp online callback.

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resc=
trl.c
> new file mode 100644
> index 0000000000000..2f31baff032b6
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c
[ ... ]
> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +	struct cbqri_controller *ctrl;
> +	int err =3D 0;
> +
> +	lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +	list_for_each_entry(ctrl, &cbqri_controllers, list) {

[Severity: High]
Is it safe to iterate the global cbqri_controllers list without holding
cbqri_controllers_lock?

If a capacity controller is dynamically added at runtime (e.g., via a device
tree overlay instantiating the platform device), its probe function can acq=
uire
cbqri_controllers_lock and mutate the cbqri_controllers list.

Concurrently, if a CPU is hotplugged, the cpuhp online callback calls
cbqri_resctrl_online_cpu() which invokes this function. Traversing the list
here while holding only cbqri_domain_list_lock could lead to list corruptio=
n,
resulting in an infinite loop or NULL pointer dereference.

> +		if (ctrl->type !=3D CBQRI_CONTROLLER_TYPE_CAPACITY)
> +			continue;
> +		if (!cpumask_test_cpu(cpu, &ctrl->cache.cpu_mask))
> +			continue;
> +		if (!ctrl->alloc_capable)
> +			continue;
> +
> +		err =3D cbqri_attach_cpu_to_cap_ctrl(ctrl, cpu);
> +		if (err) {
> +			cbqri_detach_cpu_from_all_ctrls(cpu);
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-dfustini-a=
tl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org?part=3D5
