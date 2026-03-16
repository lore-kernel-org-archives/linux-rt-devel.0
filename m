Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6276379EC6
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Mar 2026 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703694; cv=none; b=hh4HAwsI/K7xRz2fKiiQH7qoDu+/Y8JvjKCD/yfe/2FO+4pYBqSrjhod79lltQpzCgViDxAefvb7okOlru4kiT+CSmURK/caqXSxC9WSjZ/60R0dZExC93MTWIbHORGGNhoODiAWryIoYVV8vXv4g491gBogJ7RCP5nEqy6SQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703694; c=relaxed/simple;
	bh=mDvpcyUxU/3xC+bANeAIRGdwDzaQRXBf2JZBe/kSvmw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aLlzCC+uQv2YhASxs82CRKhprvAHu/QCo4/cOUuWFnuuP/Tcjs0jOHURS+cDLt/4bEiuuS29PE148UMK2m+jWgwf2fc9jjH20DMXUioXDY3HvmdnSgnRG3WICwGOdrIYoPMS6SG8zSShwrBOmcK+THZNoLWb7hj5YMuRlDoSqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqK/OpQ8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqK/OpQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773703691; x=1805239691;
  h=from:to:cc:subject:date:message-id;
  bh=mDvpcyUxU/3xC+bANeAIRGdwDzaQRXBf2JZBe/kSvmw=;
  b=CqK/OpQ8EFchd1n3OZo36QbxBoOfq1UgZRaGEkhV8fSngv1D2PB9hxve
   upBaHgmvsKCkSMXgSZiIwsHxzbvj7yGdVBELcRfNS2B0v5y/bMt/Lk2qu
   4cDeBPAVczMUnSyQm7YVnhyZe8GnQwBK9CUytNWQz+jiCWaQ4Ub8XVxoF
   H+4ebcGbjGF/cVUt1eQpsQHmJKpFU6VR0at02+5PHn/nPlQWKpdr6IiiT
   iiyFVCpkYyqSy8N8Di7OiRAkvJAwJ4TuY1Ku8BOkA+Tjyp3zng4RMoHyX
   AR8iXczYoixkB4i6e6iJLOlbRKRRw1Qg2uwNMTVPP/rLA2Xq4bNVrf41O
   A==;
X-CSE-ConnectionGUID: l/vASSWXQuy+wsVNIvVuuQ==
X-CSE-MsgGUID: 1IKSPya1SVyMnxWPmupksA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74912790"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74912790"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:28:11 -0700
X-CSE-ConnectionGUID: q6W05ur1TqWut6LWzmACxg==
X-CSE-MsgGUID: k9oZtTZ6S86bBzNBVudNTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="246842449"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa001.fm.intel.com with ESMTP; 16 Mar 2026 16:28:10 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	sgzhang@google.com,
	boolli@google.com
Subject: [PATCH iwl-net 0/3] idpf: virtchnl locking and async fixes
Date: Mon, 16 Mar 2026 16:28:16 -0700
Message-Id: <20260316232819.6872-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

The first patch in this series improves the locking around the setting
and clearing of the free_xn_bm bitmap. Previously the lock was only
taken during init shutdown and pop, but not the push function.

Patches 2 and 3 are fixes for the async handler. Patch 2 ensures the
payload size is set before the async handler is called, and patch 3 fixes
an sleeping bug due to nesting of raw/bh spinlocks.

Emil Tantilov (3):
  idpf: improve locking around idpf_vc_xn_push_free()
  idpf: set the payload size before calling the async handler
  idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling

 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 40 ++++++++++++-------
 1 file changed, 25 insertions(+), 15 deletions(-)

-- 
2.37.3

