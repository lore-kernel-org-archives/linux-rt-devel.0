Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C125E476;
	Mon,  5 May 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456440; cv=none; b=r4tOGF+y+YY8hCQ9bqf09yQu7mEcOxYye0NfXnq53RnBqn+OzJvCQBdxhejiAbQff6MjtdW1koaH+C/7wArtYqRUSHme+LDFTDtelIBj4IUhXurYM47yPfJ+USXlT8s2mtFB+f473Wzs841XC97KHGNL0qoj2WK80fcwiNwe1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456440; c=relaxed/simple;
	bh=wE4nT2xLxpIB7XTJiSrioIseWEG9d23zD4aDgBKd05Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls+6cfd+SM4/lhPHfyNAwmND3kiokbV3fo//UndGREsz4+W2R0chq9w5eSc8/Nay8O+inw3pFnrEJAtJfEnUI7o2Sbtp3Rvr7rmdyRLZvkrqG+wm5LwQDlM7zwher8Wnijp/NeQwwKYBza5HBFxO5vweeWoX7Zq+ocakGvyof0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt07HbZG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt07HbZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746456438; x=1777992438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wE4nT2xLxpIB7XTJiSrioIseWEG9d23zD4aDgBKd05Q=;
  b=Rt07HbZGjiopVg9cRO8Fjjf0x+nUotI5fEspSLbTehbMJiHBdXlJRp0g
   NFfZnc1rca1U1y9i7z8q/CMxlhkFPxF2/VlCY422HhZ851fOWTfl6CtjQ
   aKCOcqqio/cCc4XL0IaeD8dDs12+V0fuvoNxs4Acpd8aZH5D9bHpW+02p
   D5qKEFjFzd/Nx5aoj9lemNGEGhzZ9NEuC48Rrjs0aPQEFkamuWxuOZUwp
   KF3p/kTjjeUU9kf1Oj1SYkXuRce4c/+r/i5ajFNnA57JzMVlpk1uwxGeO
   OkU1huB4iKLbLECyhvcrf541rEfWVufekKym9XRAqAQwfhevzvmaHOMGO
   Q==;
X-CSE-ConnectionGUID: eFzkhUzIQa2Gaqv+G7KxOA==
X-CSE-MsgGUID: tpKDq6VNSE6yEncw9FNP7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="65601527"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="65601527"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 07:47:15 -0700
X-CSE-ConnectionGUID: 7TXq1Rm9QciuytgD3KTM1g==
X-CSE-MsgGUID: Am5BMt+bTkaEe4DPpej3nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135610547"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 May 2025 07:47:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uBx66-0005oH-04;
	Mon, 05 May 2025 14:47:10 +0000
Date: Mon, 5 May 2025 22:46:21 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, linux-rt-devel@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH] igb: Request igb_msix_other as a
 threaded interrupt handler
Message-ID: <202505052153.9092Udjg-lkp@intel.com>
References: <20250430144452.8zcAZc29@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430144452.8zcAZc29@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[also build test ERROR on tnguy-net-queue/dev-queue linus/master v6.15-rc5 next-20250502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/igb-Request-igb_msix_other-as-a-threaded-interrupt-handler/20250430-225615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250430144452.8zcAZc29%40linutronix.de
patch subject: [Intel-wired-lan] [PATCH] igb: Request igb_msix_other as a threaded interrupt handler
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250505/202505052153.9092Udjg-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250505/202505052153.9092Udjg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505052153.9092Udjg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/igb/igb_main.c:916:48: error: too few arguments to function call, expected 6, have 5
     915 |         err = request_threaded_irq(adapter->msix_entries[vector].vector,
         |               ~~~~~~~~~~~~~~~~~~~~
     916 |                                    igb_msix_other, 0, netdev->name, adapter);
         |                                                                            ^
   include/linux/interrupt.h:151:1: note: 'request_threaded_irq' declared here
     151 | request_threaded_irq(unsigned int irq, irq_handler_t handler,
         | ^                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     152 |                      irq_handler_t thread_fn,
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~
     153 |                      unsigned long flags, const char *name, void *dev);
         |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:3229:46: warning: shift count >= width of type [-Wshift-count-overflow]
    3229 |         err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
         |                                                     ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6199:14: warning: division by zero is undefined [-Wdivision-by-zero]
    6199 |         cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_VLAN,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6200 |                                  (E1000_ADVTXD_DCMD_VLE));
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6189:26: note: expanded from macro 'IGB_SET_FLAG'
    6189 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6203:14: warning: division by zero is undefined [-Wdivision-by-zero]
    6203 |         cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSO,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6204 |                                  (E1000_ADVTXD_DCMD_TSE));
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6189:26: note: expanded from macro 'IGB_SET_FLAG'
    6189 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6207:14: warning: division by zero is undefined [-Wdivision-by-zero]
    6207 |         cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6208 |                                  (E1000_ADVTXD_MAC_TSTAMP));
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6189:26: note: expanded from macro 'IGB_SET_FLAG'
    6189 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6211:14: warning: division by zero is undefined [-Wdivision-by-zero]
    6211 |         cmd_type ^= IGB_SET_FLAG(skb->no_fcs, 1, E1000_ADVTXD_DCMD_IFCS);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6189:26: note: expanded from macro 'IGB_SET_FLAG'
    6189 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6227:19: warning: division by zero is undefined [-Wdivision-by-zero]
    6227 |         olinfo_status |= IGB_SET_FLAG(tx_flags,
         |                          ^~~~~~~~~~~~~~~~~~~~~~
    6228 |                                       IGB_TX_FLAGS_CSUM,
         |                                       ~~~~~~~~~~~~~~~~~~
    6229 |                                       (E1000_TXD_POPTS_TXSM << 8));
         |                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6189:26: note: expanded from macro 'IGB_SET_FLAG'
    6189 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6232:19: warning: division by zero is undefined [-Wdivision-by-zero]
    6232 |         olinfo_status |= IGB_SET_FLAG(tx_flags,
         |                          ^~~~~~~~~~~~~~~~~~~~~~
    6233 |                                       IGB_TX_FLAGS_IPV4,
         |                                       ~~~~~~~~~~~~~~~~~~
    6234 |                                       (E1000_TXD_POPTS_IXSM << 8));
         |                                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6189:26: note: expanded from macro 'IGB_SET_FLAG'
    6189 |          ((u32)(_input & _flag) / (_flag / _result)))
         |                                 ^ ~~~~~~~~~~~~~~~~~
   7 warnings and 1 error generated.


vim +916 drivers/net/ethernet/intel/igb/igb_main.c

9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  901  
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  902  /**
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  903   *  igb_request_msix - Initialize MSI-X interrupts
b980ac18c95f325 drivers/net/ethernet/intel/igb/igb_main.c Jeff Kirsher              2013-02-23  904   *  @adapter: board private structure to initialize
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  905   *
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  906   *  igb_request_msix allocates MSI-X vectors and requests interrupts from the
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  907   *  kernel.
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  908   **/
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  909  static int igb_request_msix(struct igb_adapter *adapter)
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  910  {
6c19d772618fea4 drivers/net/ethernet/intel/igb/igb_main.c Aleksandr Loktionov       2021-04-22  911  	unsigned int num_q_vectors = adapter->num_q_vectors;
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  912  	struct net_device *netdev = adapter->netdev;
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  913  	int i, err = 0, vector = 0, free_vector = 0;
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  914  
086e5c4c0db155f drivers/net/ethernet/intel/igb/igb_main.c Sebastian Andrzej Siewior 2025-04-30  915  	err = request_threaded_irq(adapter->msix_entries[vector].vector,
50d325bb05cef24 drivers/net/ethernet/intel/igb/igb_main.c Wander Lairson Costa      2024-11-06 @916  				   igb_msix_other, 0, netdev->name, adapter);
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  917  	if (err)
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  918  		goto err_out;
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  919  
6c19d772618fea4 drivers/net/ethernet/intel/igb/igb_main.c Aleksandr Loktionov       2021-04-22  920  	if (num_q_vectors > MAX_Q_VECTORS) {
6c19d772618fea4 drivers/net/ethernet/intel/igb/igb_main.c Aleksandr Loktionov       2021-04-22  921  		num_q_vectors = MAX_Q_VECTORS;
6c19d772618fea4 drivers/net/ethernet/intel/igb/igb_main.c Aleksandr Loktionov       2021-04-22  922  		dev_warn(&adapter->pdev->dev,
6c19d772618fea4 drivers/net/ethernet/intel/igb/igb_main.c Aleksandr Loktionov       2021-04-22  923  			 "The number of queue vectors (%d) is higher than max allowed (%d)\n",
6c19d772618fea4 drivers/net/ethernet/intel/igb/igb_main.c Aleksandr Loktionov       2021-04-22  924  			 adapter->num_q_vectors, MAX_Q_VECTORS);
6c19d772618fea4 drivers/net/ethernet/intel/igb/igb_main.c Aleksandr Loktionov       2021-04-22  925  	}
6c19d772618fea4 drivers/net/ethernet/intel/igb/igb_main.c Aleksandr Loktionov       2021-04-22  926  	for (i = 0; i < num_q_vectors; i++) {
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  927  		struct igb_q_vector *q_vector = adapter->q_vector[i];
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  928  
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  929  		vector++;
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  930  
7b06a6909555ffb drivers/net/ethernet/intel/igb/igb_main.c Jarod Wilson              2015-10-19  931  		q_vector->itr_register = adapter->io_addr + E1000_EITR(vector);
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  932  
0ba829943c5180d drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck           2011-08-26  933  		if (q_vector->rx.ring && q_vector->tx.ring)
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  934  			sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
0ba829943c5180d drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck           2011-08-26  935  				q_vector->rx.ring->queue_index);
0ba829943c5180d drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck           2011-08-26  936  		else if (q_vector->tx.ring)
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  937  			sprintf(q_vector->name, "%s-tx-%u", netdev->name,
0ba829943c5180d drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck           2011-08-26  938  				q_vector->tx.ring->queue_index);
0ba829943c5180d drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck           2011-08-26  939  		else if (q_vector->rx.ring)
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  940  			sprintf(q_vector->name, "%s-rx-%u", netdev->name,
0ba829943c5180d drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck           2011-08-26  941  				q_vector->rx.ring->queue_index);
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  942  		else
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  943  			sprintf(q_vector->name, "%s-unused", netdev->name);
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  944  
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  945  		err = request_irq(adapter->msix_entries[vector].vector,
a0607fd3a25ba18 drivers/net/igb/igb_main.c                Joe Perches               2009-11-18  946  				  igb_msix_ring, 0, q_vector->name,
047e0030f1e6012 drivers/net/igb/igb_main.c                Alexander Duyck           2009-10-27  947  				  q_vector);
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  948  		if (err)
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  949  			goto err_free;
1911329ae9ce059 drivers/net/ethernet/intel/igb/igb_main.c Kurt Kanzenbach           2025-03-19  950  
1911329ae9ce059 drivers/net/ethernet/intel/igb/igb_main.c Kurt Kanzenbach           2025-03-19  951  		netif_napi_set_irq(&q_vector->napi,
1911329ae9ce059 drivers/net/ethernet/intel/igb/igb_main.c Kurt Kanzenbach           2025-03-19  952  				   adapter->msix_entries[vector].vector);
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  953  	}
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  954  
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  955  	igb_configure_msix(adapter);
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  956  	return 0;
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  957  
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  958  err_free:
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  959  	/* free already assigned IRQs */
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  960  	free_irq(adapter->msix_entries[free_vector++].vector, adapter);
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  961  
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  962  	vector--;
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  963  	for (i = 0; i < vector; i++) {
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  964  		free_irq(adapter->msix_entries[free_vector++].vector,
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  965  			 adapter->q_vector[i]);
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  966  	}
52285b762b36816 drivers/net/ethernet/intel/igb/igb_main.c Stefan Assmann            2012-12-04  967  err_out:
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  968  	return err;
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  969  }
9d5c824399dea88 drivers/net/igb/igb_main.c                Auke Kok                  2008-01-24  970  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
